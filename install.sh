#!/bin/bash

## First, check to see if we're running as root (we need to be in user-space to check for Pipewire)
if [ "$EUID" -eq 0 ]; then
	echo "Do not run this script as root.";
	exit;
fi

## Check whether the audio system is currently pipewire (this is why we can't be root!)..
pactl info | grep 'Server Name' | grep -v 'on PipeWire' >> /dev/null
if [ "$?" -eq 1 ]; then
	echo "This script isn't supported on Pipewire Based Systems";
	exit;
fi

echo "This script requires root for several operations, and may prompt for your password as it runs."
sudo rm -rf /etc/goxlr

APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)

sudo mkdir /etc/goxlr
cd /etc/goxlr || exit 1
if [ -n "$APT_GET_CMD" ]; then
    dpkg -s git >word 2<&1 || sudo apt-get install git
elif [ -n "$PACMAN_CMD" ]; then
    sudo pacman -Qs git || sudo pacman -S git
fi
sudo git clone https://github.com/GoXLR-on-Linux/goxlr-on-linux.git || skip
cd goxlr-on-linux || exit 1
#Config location
CONFIG="$HOME/GoXLR.cfg"

#Create config if it doesn't exist
if [ ! -e $CONFIG ]; then
    sudo cp "/etc/goxlr/goxlr-on-linux/bin/raw.cfg" $CONFIG
    sudo chown -c $USER $CONFIG
fi

#Source config
. $CONFIG

#Function to edit config file
#Use is: set_config "valueToChange" "changeToWhat"
set_config(){
    sudo sed -i "s/^\($1\s*=\s*\).*\$/\1$2/" $CONFIG

    #Source the config again so information is up to date
    . $CONFIG
}

#Ask user a config question
#Use is: ask_config configOption question option1 option2
ask_config(){
    #Dummy var to trap the script in loop until an acceptable answer is input
    allowed=
    while [ ! $allowed ]; do
        echo -n "$2 Options: $3, $4: "
        read REPLY

        #Lowercase reply and check against options to see if it's acceptable
        fixReply="$(echo ${REPLY} | tr 'A-Z' 'a-z')"
        if [ $fixReply = $3 ] || [ $fixReply = $4 ]; then
            set_config $1 $fixReply
            allowed='true'
        else
            echo "$REPLY isn't an option."
        fi
    done
}

echo

#Ask type of GoXLR, full or mini
ask_config "device" "GoXLR Full or Mini?" "full" "mini"

#Ask which sound system to use, pulseaudio or pipewire
#ask_config "type" "Which sound system?" "pulseaudio" "pipewire"

echo "Working..."

#Install
if [ -n "$APT_GET_CMD" ]; then
    cd $HOME || exit 1
    dpkg -s jackd2 >word 2>&1 || sudo apt-get install jackd2
    dpkg -s pulseaudio-module-jack >word 2>&1 || sudo apt-get install pulseaudio-module-jack
    grep -iq "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" \.profile || sudo echo "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" | sudo tee -a ".profile"
elif [ -n "$PACMAN_CMD" ]; then
    sudo pacman -Qs jack2 || sudo pacman -S jack2
    sudo pacman -Qs jack2-dbus || sudo pacman -S jack2-dbus
    sudo pacman -Qs pulseaudio-jack || sudo pacman -S pulseaudio-jack
    sudo pacman -Qs jack-example-tools || sudo pacman -S jack-example-tools
    cd $HOME || exit 1
    grep -iq "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" \.bash_profile || sudo echo "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" | sudo tee -a ".bash_profile"
    cd /etc/goxlr/goxlr-on-linux || exit 1
    sudo cp audio.conf /etc/security/limits.d
else
    echo "error can't install packages"
    exit 1;
fi

#Restart PA
pulseaudio --kill

#Default cmode for testing both options
set_config "cmode" "false"

#Run GoXLR
sh /etc/goxlr/goxlr-on-linux/run_goxlr.sh|grep "not a valid port" && set_config "cmode" "true" && sh /etc/goxlr/goxlr-on-linux/run_goxlr|grep "not a valid port" && printf "Your GoXLR has been powercycled or was not found.\nPlease look in the wiki for other known issues,\nif it isn't a know issue Please create one on github\nand attach the GoXLR_Log.txt found in your home directory.\n" && sh /etc/goxlr/goxlr-on-linux/genlog.sh


#clear console
clear

#Config default output device
echo "Output Devices"
case "${1:-}" in
    (""|list)
        outputs=$(pacmd list-sinks |
        #Filter for jack.client_name, remove quotes, number results
        grep -E 'jack.client_name' | sed 's/		jack.client_name = //g' | sed 's/"//g' | nl -ba -s') ')
        echo "$outputs"

        #Dummy var to trap the script in loop until an acceptable answer is input
        allowed=
        while [ ! $allowed ]; do
            #Ask which device to use
            echo -n "Please type a number to pick a default output device (0 to skip): "
            read REPLY

            #Set selection
            selected=$(echo "$outputs" | grep -E $REPLY | sed 's/     '$REPLY') //g')

            #Check if valid option and name found
            if [ $REPLY = '0' ]; then
                echo "Skipping option."
                allowed="true"
            elif [ ! $selected ]; then
            	echo "Invalid option selected."
            else
                echo $selected "was selected."
                echo
                allowed="true"
            fi
        done
    ;;
esac

if [ $selected ]; then
    #Filter for both names, remove $selected and get line before it
    found=$(pacmd list-sinks | grep -E "$selected|name:" | grep -B 1 $selected | sed '/'$selected'/d' |
    #Sed off unneeded characters
    sed 's/[ 	<>]//g' | sed 's/name://g')

    #Set config and apply default device
    set_config "ouput" $selected
    pacmd "set-default-sink $found"
fi

#Config default input device
echo "Input Devices"
case "${1:-}" in
    (""|list)
        inputs=$(pacmd list-sources |
        #Filter for jack.client_name, remove quotes, number results
        grep -E 'jack.client_name' | sed 's/		jack.client_name = //g' | sed 's/"//g' | nl -ba -s') ')
        echo "$inputs"

        #Dummy var to trap the script in loop until an acceptable answer is input
        allowed=
        while [ ! $allowed ]; do
            #Ask which device to use
            echo -n "Please type a number to pick a default input device (0 to skip): "
            read REPLY

            #Set selection
            selected=$(echo "$inputs" | grep -E $REPLY | sed 's/     '$REPLY') //g')

            #Check if valid option and name found
            if [ $REPLY = '0' ]; then
                echo "Skipping option."
                allowed="true"
            elif [ ! $selected ]; then
            	echo "Invalid option selected."
            else
                echo $selected "was selected."
                echo
                allowed="true"
            fi
        done
    ;;
esac

if [ $selected ]; then
    #Filter for both names, remove $selected and get line before it
    found=$(pacmd list-sources | grep -E "$selected|name:" | grep -B 1 $selected | sed '/'$selected'/d' |
    #Sed off unneeded characters
    sed 's/[ 	<>]//g' | sed 's/name://g')

    #Set config and apply default device
    set_config "input" $selected
    pacmd "set-default-source $found"
fi

#Finished
echo "Install complete. Configured using a '$device' GoXLR with '$ouput' as your default output and '$input' as your default input."

#!/bin/sh

#Config location
CONFIG="/etc/goxlr/goxlr-on-linux/GoXLR.cfg"

#Create config if it doesn't exist
if [ ! -e $CONFIG ]; then
    sudo cp "/etc/goxlr/goxlr-on-linux/bin/raw.cfg" $CONFIG
fi

#Source config
. $CONFIG

#Function to edit config file
#Use is: set_config "valueToChange" "changeToWhat"
set_config(){
    sudo sed -i "s/^\($1\s*=\s*\).*\$/\1$2/" $CONFIG
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

    #Source the config again so information is up to date
    . $CONFIG
}

#Ask type of GoXLR, full or mini
ask_config "device" "GoXLR Full or Mini?" "full" "mini"

#Ask which sound system to use, pulseaudio or pipewire
#ask_config "type" "Which sound system?" "pulseaudio" "pipewire"

#Install
APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)

sudo rm -rf /etc/goxlr

sudo mkdir /etc/goxlr
cd /etc/goxlr || exit 1
sudo git clone https://github.com/GoXLR-on-Linux/goxlr-on-linux.git
cd goxlr-on-linux || exit 1

if [ -n "$APT_GET_CMD" ]; then
    cd $HOME || exit 1
    dpkg -s jackd2 >word 2>&1 || sudo apt-get install jackd2
    dpkg -s pulseaudio-module-jack >word 2>&1 || sudo apt-get install pulseaudio-module-jack
    grep -iq "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" \.profile || sudo echo "source /etc/goxlr/goxlr-on-linux/run_goxlr.sh" | sudo tee -a ".profile"
elif [ -n "$PACMAN_CMD" ]; then
    sudo pacman -Qs jack2 || sudo pacman -S jack2
    sudo pacman -Qs jack2-dbus || sudo pacman -S jack2-dbus
    sudo pacman -Qs pulseaudio-jack || sudo pacman -S pulseaudio-jack
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
clear

#Run GoXLR
sh /etc/goxlr/goxlr-on-linux/run_goxlr.sh|grep "not a valid port" && set_config cmode "true" && sh /etc/goxlr/goxlr-on-linux/run_goxlr|grep "not a valid port" && printf "Your GoXLR has been powercycled or was not found.\nPlease look in the wiki for other known issues,\nif it isn't a know issue Please create one on github\nand attach the GoXLR_Log.txt found in your home directory.\n" && sh /etc/goxlr/goxlr-on-linux/genlog.sh


#echo "Output Devices"
#case "${1:-}" in
#  (""|list)
#    pacmd list-sinks |
#      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
#    ;;
#esac
#echo " "

#Ask user for default device (Not sure how to make use of this info yet)

#echo "Input Devices"
#case "${1:-}" in
#  (""|list)
#    pacmd list-sources |
#      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
#    ;;
#esac
#echo " "

#Ask user for default device (Not sure how to make use of this info yet)


#TODO
#Ask user for full or mini GoXLR --Done
#Ask user PulseAudio or Pipewire? Maybe --Done but noted until we get there
#Normal install --Done
#Kill pulseaudio --Done
#Run GoXLR --Done
#Ask user if they see "XYZ is not a valid port" --Done
#--If yes, run without the ,0 from hw:GoXLR,0 and retest --Done
#--If no continue --Done
#Print all devices ask user for defaults

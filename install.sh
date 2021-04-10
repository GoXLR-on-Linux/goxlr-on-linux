#!/bin/sh


APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)

sudo rm -rf /etc/goxlr

sudo mkdir /etc/goxlr
cd /etc/goxlr
sudo git clone https://github.com/lm41/goxlr-on-linux.git
cd goxlr-on-linux

if [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install jackd2 pulseaudio-module-jack
    if [[ "$1" = "MINI" ]]; then
        sudo echo "source /etc/goxlr/goxlr-on-linux/configure_goxlr_mini.sh" >> "$HOME.profile"
    else
        sudo echo "source /etc/goxlr/goxlr-on-linux/configure_goxlr.sh" >> "$HOME.profile"
    fi

elif [[ ! -z $PACMAN_CMD ]]; then
    sudo pacman -S jack2 jack2-dbus pulseaudio-jack
    if [[ "$1" = "MINI" ]]; then
        sudo echo "source /etc/goxlr/goxlr-on-linux/configure_goxlr_mini.sh" | sudo tee -a  ".bash_profile" > /dev/null
    else
        sudo echo "source /etc/goxlr/goxlr-on-linux/configure_goxlr.sh" | sudo tee -a  ".bash_profile" > /dev/null
    fi
    cd /etc/goxlr/goxlr-on-linux
    sudo cp audio.conf /etc/security/limits.d

else
    echo "error can't install packages"
    exit 1;
fi

sudo reboot

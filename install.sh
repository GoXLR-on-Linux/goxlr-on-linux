#!/bin/sh


APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)

sudo mkdir /etc/goxlr
cd /etc/goxlr
sudo git clone https://github.com/T-Grave/goxlr-on-linux.git
cd goxlr-on-linux



if [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install jackd2 pulseaudio-module-jack
    if [[ "$1" = "MINI" ]]; then
        sudo echo "source /etc/goxlr-on-linux/configure_goxlr_mini.sh" >> ".profile"
    else
        sudo echo "source /etc/goxlr-on-linux/configure_goxlr.sh" >> ".profile"
elif [[ ! -z $PACMAN_CMD ]]; then
    sudo pacman -S jack2 jack2-dbus pulseaudio-jack
    if [[ "$1" = "MINI" ]]; then
        sudo echo "source /etc/goxlr-on-linux/configure_goxlr_mini.sh" >> ".bash_profile"
    else
        sudo echo "source /etc/goxlr-on-linux/configure_goxlr.sh" >> ".bash_profile"

    sudo mv audio.config /etc/security/limits.d
else
    echo "error can't install packages"
    exit 1;
fi


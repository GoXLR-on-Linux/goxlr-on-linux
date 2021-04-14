#!/bin/sh


APT_GET_CMD=$(which apt-get)
PACMAN_CMD=$(which pacman)

sudo rm -rf /etc/goxlr

sudo mkdir /etc/goxlr
cd /etc/goxlr
sudo git clone https://github.com/T-Grave/goxlr-on-linux.git
cd goxlr-on-linux

if [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install jackd2 pulseaudio-module-jack
    if [[ "$1" = "MINI" ]]; then
        sudo chmod u+x /etc/goxlr/goxlr-on-linux/configure_goxlr_mini.sh
        sudo systemctl enable run-at-startup.service
        cd /etc/goxlr/goxlr-on-linux
        sudo cp run-at-startup.service /etc/systemd/system/
    else
        sudo chmod u+x /etc/goxlr/goxlr-on-linux/configure_goxlr.sh
        sudo systemctl enable run-at-startup.service
        cd /etc/goxlr/goxlr-on-linux
        sudo cp run-at-startup.service /etc/systemd/system/
    fi

elif [[ ! -z $PACMAN_CMD ]]; then
    sudo pacman -S jack2 jack2-dbus pulseaudio-jack
    if [[ "$1" = "MINI" ]]; then
        sudo chmod u+x /etc/goxlr/goxlr-on-linux/configure_goxlr_mini.sh
        sudo systemctl enable run-at-startup.service
        cd /etc/goxlr/goxlr-on-linux
        sudo cp run-at-startup.service /etc/systemd/system/
    else
        sudo chmod u+x /etc/goxlr/goxlr-on-linux/configure_goxlr.sh
        sudo systemctl enable run-at-startup.service
        cd /etc/goxlr/goxlr-on-linux
        sudo cp run-at-startup.service /etc/systemd/system/
    fi
    sudo cp audio.conf /etc/security/limits.d

else
    echo "error can't install packages"
    exit 1;
fi


sudo reboot

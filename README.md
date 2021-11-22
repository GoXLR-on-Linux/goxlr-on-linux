# goxlr-on-linux

[![Support Server](https://img.shields.io/discord/828348446775574548.svg?label=Discord&logo=Discord&colorB=7289da&style=flat)](https://discord.gg/Wbp3UxkX2j)

Documentation and scripts to make the GoXLR and GoXLR Mini useful on Linux.

- All of the output and input channels are available (System, Chat, Music, ...)
- The Faders work
- The bleep button (`!@#$?*`) works
- The Mute buttons DO NOT WORK
- The Sampler buttons DO NOT WORK
- The Effects buttons DO NOT WORK
- The Cough button DOES NOT WORK

And also, you do still need a Windows with the official GoXLR App to initialize the GoXLR **everytime it loses power**!
That means either passing it through to a VM, or dual-booting.

## Requirements

### Linux Kernel >= 5.11.x
Older kernels technically work, but most people experience a lot of audio stutter and skipping on older kernels.

### PulseAudio
A lot of Linux distributions ship with PulseAudio by default.

### JACK2 and pulseaudio-module-jack
The required packages are installed during the installation

## Installation

#### Download the `install.sh` script, and execute it:
These commands must be executed in the console. To do this, open the terminal, paste the following lines and press enter:
```
wget https://github.com/GoXLR-on-Linux/goxlr-on-linux/raw/main/install.sh
sudo chmod +x ./install.sh
sudo ./install.sh
```
The script should request your configuration and save it.

## Usage
If you've set the script to run on startup, everything should work out of the box.


### IMPORTANT


> This script only works if the GoXLR is not turned off after a profile has been loaded in Windows. The GoXLR Mini, which is powered through USB, will lose it's configuration when you reboot unless you plug it into a port that ALWAYS supplies power (even when the system is turned off or reboots).


## [FAQ](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/FAQ)


## [Common issues](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/Common-issues#common-issues)


## Disclaimer
This project is not in any way affiliated with TC-Hellicon. There is no official support for GoXLR (Mini) and Linux. This project, or any of its contributers cannot be held responsible for any issues you experience with your device, before or after using the scripts or documentation provided.

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

#### Download the `install.sh` script, and execute it.


## Usage
If you've set the script to run on startup, everything should work out of the box.


### IMPORTANT


> This script only works if the GoXLR is not turned off after a profile has been loaded in Windows. The GoXLR Mini, which is powered through USB, will lose it's configuration when you reboot unless you plug it into a port that ALWAYS supplies power (even when the system is turned off or reboots).


## [FAQ](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/FAQ)


## Common issues

### Cannot lock down 107341338 byte memory area (Cannot allocate memory)
Open a terminal and execute the following command : `usermod -a -G audio YOURNAMEUSER`

### ERROR GoXLR_Source_Chat:XXX not a valid port
Go to Windows and load your profile to your GoXLR and make sure when rebooting into Linux, the GoXLR does not power reset.
> GoXLR Mini: You will need a powered USB hub or a USB port on your Motherboard that supplies power even when the computer reboots/powers off

### My audio is stuttering / skipping?
Make sure you are running Kernel **5.11 or newer**.

### My channels are muted and I can't unmute them
The buttons don't work on Linux atm, you can only unmute the channels from Windows.

## Disclaimer
This project is not in any way affiliated with TC-Hellicon. There is no official support for GoXLR (Mini) and Linux. This project, or any of its contributers cannot be held responsible for any issues you experience with your device, before or after using the scripts or documentation provided.

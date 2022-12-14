# goxlr-on-linux

[![Support Server](https://img.shields.io/discord/828348446775574548.svg?label=Discord&logo=Discord&colorB=7289da&style=flat)](https://discord.gg/Wbp3UxkX2j)

Documentation and scripts to make the GoXLR and GoXLR Mini useful on Linux.

## Installation
Firstly, plug in your GoXLR and check to see if the audio devices have automatically appeared (generally by clicking on the Sound applet, or 'Audio' in your System Settings). If you see the GoXLR Devices (Chat, System, Music, et al.), you *DO NOT* need to use this script. You should be good to go with [basic functionality](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/Basic-Functionality).

If you are running one of the following distributions, and the devices don't show up automatically:
* Ubuntu 22.10+
* Pop!_OS 22.04+
* Fedora 36+
* Arch / Manjaro

*DO NOT* run the script. Open an Issue, or hit us up on [Discord](https://discord.gg/Wbp3UxkX2j) so we can help walk through the problem.

If your distribution isn't in that list, please check [This Wiki Page](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/Out-of-Box-Support) for the minimum requirements of 'Out of the Box' support, if your distro meets those requirements but you're having problems, again, open an issue or message us on Discord. If your distribution isn't on the list and the GoXLR works out the box let us know so we can update the list.

If you don't meet the minimum requirements for Out of the Box support this script is for you. Head over the the [Installation Instructions](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/Requirements-and-Installation-Instructions) to proceed.

## The GoXLR Utility
When using only out-of-box support, or this script, you will receive [Basic Functionality](https://github.com/GoXLR-on-Linux/goxlr-on-linux/wiki/Basic-Functionality) from the GoXLR.

We've been working on the [GoXLR Utility](https://github.com/GoXLR-on-Linux/goxlr-utility/) to resolve this. It's a tool which allows for all functionality of the GoXLR (including initialization, mute buttons, effects and samplers) to work natively under Linux. It's still considered early-alpha so isn't feature complete, but does support some important features such as initialisation, profile and mic profile loading and management, button behaviours etc. The utility is available as a .deb or .rpm from the [Releases Page](https://github.com/GoXLR-on-Linux/goxlr-utility/releases), or from the Arch User Repository (AUR) as `goxlr-utility`. If you're using a GoXLR on Linux, we highly recommend you also use this to get the most out of your GoXLR!

## PulseAudio vs Pipewire
While the GoXLR will work with both Pulse Audio and Pipewire, Pulse may result in audio latency between 0.1 and 3 seconds in certain situations. Pipewire doesn't seem to suffer from the same problem. As far as why? We've not really spent any time looking. Most of the team here use Pipewire, and pipewire is also gradually becoming the dominant audio server (A lot of major distros now ship with it by default). If anyone is able to determine why the latency on Pulse is so bad, as well as how to fix it, let us know so we can document it for others, otherwise, if you're comfortable in doing so, it may make more sense to look into switching to pipewire instead for an optimal experience. Check your distros docs for details!

## Disclaimer
This project is not in any way affiliated with TC-Hellicon. There is no official support for GoXLR (Mini) and Linux. This project, or any of its contributers cannot be held responsible for any issues you experience with your device, before or after using the scripts or documentation provided.

# goxlr-on-linux
Documentation and scripts to make the GoXLR and GoXLR Mini useful on Linux.

- All of the output and input channels are available (System, Chat, Music, ...)
- The Faders work
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

#### Ubuntu
```
sudo apt install jackd2 pulseaudio-module-jack
```

## Installation

#### 1. Add the `configure_goxlr.sh` script somewhere on your system (/opt, or home folder)
#### 2. Make sure to change the `hw:GoXLR,0` line to `hw:GoXLRMini,0` if you're using the Mini
#### 3. Add `source /path/to/configure_goxlr.sh` to your `.profile` file
#### 4. Reboot


## Usage
If you've set the script to run on startup, everything should work out of the box.


### IMPORTANT


> This script only works if the GoXLR is not turned off after a profile has been loaded in Windows. The GoXLR Mini, which is powered through USB, will lose it's configuration when you reboot unless you plug it into a port that ALWAYS supplies power.


## FAQ

### How does it work?
The script uses JACK2 to wire all of the GoXLR channels to custom PulseAudio sinks and sources.

### How reliable is this?
Personally I've been running this for a couple of weeks now and it has not failed once. If you do experience any instability or issues, feel free to create a ticket.

### My audio is stuttering / skipping?
Make sure you are running Kernel **5.11 or newer**.

### Why is there stutter / skipping on older kernels?
Check out [this comment](https://bugzilla.kernel.org/show_bug.cgi?id=211211#c10) by one of the ALSA driver developers.

### Can I configure my GoXLR through the GoXLR App on Linux?
No. You could run a Windows VM and passthrough the GoXLR USB port and configure it through there.

### How can I configure specific apps (Spotify, ...) to use a specific Output?
One way to achieve this is using `pavucontrol`

### My channels are muted and I can't unmute them
The buttons don't work on Linux atm, you can only unmute the channels from Windows.

### How to change the routing?
You need to change the routing in Windows.

### Will the buttons ever work on Linux?
We might be able to Reverse Engineer the USB signals and write our own simplified driver to have some of the more simple buttons (mute) working. I have no personal experience with this, so this is just a guess atm.


## Disclaimer
This project is not in any way affiliated with TC-Hellicon. There is no official support for GoXLR (Mini) and Linux. This project, or any of its contributers cannot be held responsible for any issues you experience with your device, before or after using the scripts or documentation provided.

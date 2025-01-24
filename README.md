# FreeBSD-Bluetooth-Audio
A simple yet effective script for getting bluetooth audio working automatically on FreeBSD. This has been tested on Release 14.2

## Notice
This script is experimental and you are expected to read through the script and make changes accordingly before executing any commands, **I am not responsible for your carelessness.**

Please do initially setup Bluetooth for headphone use through this set of instructions:
https://forums.freebsd.org/threads/bluetooth-audio-how-to-connect-and-use-bluetooth-headphones-on-freebsd.82671/

After that has been done, this script aims to automate that process and make it a bit easier to do. **It's definitely not the most beutiful way to automate it, but it seems to get the job done.** You will need to modify the script before running it, see instructions on how to do that below.


## Recommended edits

```
$bd_addr = "" #Ex. headphones
$defaut_volume = 2
$output = "" #Ex. dsp1
$refresh = 180
```

**BD_ADDR** needs to be either the alias or the actual BD_ADDR of the bluetooth device you are connecting to.

**default_volume** is set to **2** as default, you can set it to whatever you please.

**output** for some, setting this to **dsp1** should work. If it throws you an error, see which output devices are available in /dev/ and pick the appropriate one. Ex. dsp3

**refresh** takes 180 seconds (3 minutes) by default. This is how often pacat gets restarted to ensure that the audio won't start delaying. If you feel like it restarts too often *(you'll notice hiccups every 3 minutes)*, you could change this value accordingly.



## Dependencies

This script uses **sudo**, if you happen to use another utility to get access to root commands, **please edit the appropriate parts of the script to fit your needs.**




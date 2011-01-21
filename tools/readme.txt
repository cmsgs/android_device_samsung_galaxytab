This is a beta build of CyanogenMod 6 froyo
by Technomancer TCMAN-dmg on freenode.net and irc.droid-life.com

Bug reports: open issues at http://github.com/techomancer/android_device_samsung_galaxytab

This build is for beta testing, not for general consumption

CREDITS

See http://cmsgs.com for more info
The github for CMSGS Tab is http://github.com/cmsgs

It is based on great work of CM SGS team http://cmsgs.com

Thanks to codeworkx, coolya and noobnl and all beta testers.

INSTALLATION

Your Tab should be partitioned with P1_add_hidden
Wipe your Tab (data, dbdata, cache)
Flash it with heimdall (use simple flashme script for full flash)
Or just flash zImage and factoryfs.ext4.

For Google apps download latest HDPI apps from http://goo-inside.me/google-apps/ or http://android.d3xt3r01.tk/cyanogen/gapps and install using recovery.

What works
Phone calls, data
Wifi
Bluetooth Keyboard
GPS
Buttons backlight - linked to LCD backlight
Sensors:
- BMA020/BMA150 Accelerometer
- AK8973B

What doesn't
Camera
Sensors:
- BH1721FVC light sensor
- L3G4200D gyro
- Some are probably screwed up because of hwrotation = 90
Bluetooth Audio

Issues and workarounds
* Stuck on CM boot ani after flash
    Probably / data is not mounted. 
    run "adb shell mount"
    it will show list of mounted partitions, if /data is not mounted to /dev/block/mmcblk0p2 as rfs, format the /data partiton.
    To do that "adb reboot recovery". "adb shell" when in recovery, "parted /dev/block/mmcblk0", initialize/format partition 2 to fat32 using "mkfs 2 fat32"

* BT doesnt start
    Try again
    Try rebooting
    If that doesnt help try "adb shell stop hciattach" Sometimes hciattach service gets stuck when starting. I have added code to stop it automatically.

Latest fixes:

2011-01-20
Replaced lights with my own built from source
The linking of backlight and button light is now done in lights module instead of java LightsService
Replace copybit and s3cjpeg modules with ones from noobnl's samsung/common

2011-01-19
Switch to Nexus S libaudio. Much simpler, doesn't crash and Bluetooth headset shows some signs of life.

2011-01-17
Fix p1_keyboard.kl, remove key codes unsupported in CM. add left and right alt.
Fixed exec flags on recovery executables

2011-01-16
Moved everything to http://github.com/cmsgs
This build should be functionally the same as previous one

2011-01-15
Fix vold configuration so usb mount/unmount works
Add code to bt_enable to stop hciattach service if it is stuck.

older
Switched back to binary vold which is better and enables UMS
Force Phone app to start with speaker on
Switch to su built from sources

--
Dominik


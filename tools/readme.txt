This is a beta build of CyanogenMod 7 gingerbread
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
It should have unsigned bootloaders that can load Euro ROMs
Wipe your Tab (data, dbdata, cache)
Flash it with heimdall (use simple flashme script for full flash)
Or just flash zImage and factoryfs.ext4.

For Google apps download latest HDPI apps for Gingerbread http://goo-inside.me/gapps/ and install using recovery.

Status
Voice: OK
3G Data: connection established but default route not set
Wifi: works
BT: sometimes stuck on startup, doesnt fully pair
GPS: broken
Buttons backlight - linked to LCD backlight
Sensors:
- BMA020/BMA150 Accelerometer
- AK8973B: gravity OK, rest needs tuning
- BH1721FVC Lightsensor: OK
- L3G4200D gyro: uninmplemented
- Proximity: faked at 10cm
Camera: not tested

Issues and workarounds
* Stuck on CM boot ani after flash
    Probably / data is not mounted. 
    run "adb shell mount"
    it will show list of mounted partitions, if /data is not mounted to /dev/block/mmcblk0p2 as rfs, format the /data partiton.
    To do that "adb reboot recovery". "adb shell" when in recovery, "parted /dev/block/mmcblk0", initialize/format partition 2 to fat32 using "mkfs 2 fat32"

* BT doesnt start
    Try again
    Try rebooting
    If that doesnt help try "adb shell stop hciattach" Sometimes hciattach service gets stuck when starting.

Changelog:
2011-01-29 Fixed 3G data

2011-01-28 First beta release


--
Dominik


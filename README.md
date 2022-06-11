# motioneyeos_ext
A small set of scripts useful to add specific functionalities to [Motioneyeos](https://github.com/ccrisan/motioneyeos) (tested on Raspberry Pi Zero, but I think is possible to use on other versions of Motioneyeos)

#### Table of Contents

- [motioneyeos_ext](#motioneyeos_ext)
      - [Table of Contents](#table-of-contents)
  - [Tailscale on MotioneyeOS](#tailscale-on-motioneyeos)
  - [Rclone on MotioneyeOS and Motioneye DietPi](#rclone-on-motioneyeos-and-motioneye-dietpi)
      - [Parameters](#parameters)
      - [Configuration files](#configuration-files)
      - [Sample Cron configuration](#sample-cron-configuration)
  - [Motioneye on DietPi v8.5.x (Raspberry Pi ARMv6 or ARMv7)](#motioneye-on-dietpi-v85x-raspberry-pi-armv6-or-armv7)

## Tailscale on MotioneyeOS

Website: [Tailscale](https://tailscale.com/)

Script: [`S98tailscale`](src/S98tailscale)

To install or update Tailscale:

* Install Motioneyeos (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation))
* Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
* Run the command:

```
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/main/src/S98tailscale -o /tmp/S98tailscale && bash /tmp/S98tailscale install
```

* Reboot your Raspberry Pi (with the command: `reboot`).
* Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
* Run the command: `tailscale up` and configure using your Tailscale credentials.

## Rclone on MotioneyeOS and Motioneye DietPi

Website: [Rclone](https://rclone.org/)

Script: [`rclone_tool.sh`](src/rclone_tool.sh)

To install or update Rclone:

* Install Motioneyeos or DietPi on your Raspberry Pi (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation)) or [https://dietpi.com/docs/install/](https://dietpi.com/docs/install/))
* Connect via ssh to your Raspberry Pi where you have installed Motioneyeos (or DietPi) (eg.: `ssh admin@192.168.1.50`)
* Run the command:

```
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/main/src/rclone_tool.sh -o /tmp/rclone_tool.sh && bash /tmp/rclone_tool.sh install
```

* Reboot your Raspberry Pi (with the command: `reboot`).
* Connect via ssh to your Raspberry Pi where you have installed Motioneyeos (or DietPi) (eg.: `ssh admin@192.168.1.50`)
* Configure Rclone: `rclone_tool config`

#### Parameters

`rclone_tool install`: installs Rclone on your device. The destination folder of Rclone and configuration files will be: `/usr/bin/`.

`rclone_tool config`: configures Rclone, remote and local folders. The configuration procedure has two different steps. The first step configures Rclone and the second step configures the local camera folder and remote folder.

`rclone_tool run <copy|move> <RCLONE_NAME_DEST>`: runs Rclone. It's possible to copy or move files. Requires the destination Rclone configuration (same used to configure it). This command is useful to be configured and scheduled with `cron`.

#### Configuration files

Two different configuration files  will be create after configuration:

* `/usr/bin/rclone.config`: contains the credentials to access to remote folder.
* `/usr/bin/rclone_local.config`: contains the local data camera folder and remote folder. This file is used from command: `rclone_tool run <copy|move> <RCLONE_NAME_DEST>`.

#### Sample Cron configuration
```
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)  OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  *  command to be executed
# *  *  *  *  *  command --arg1 --arg2 file1 file2 2>&1

*/15 *  *  *  *  /usr/bin/rclone_tool.sh run move remote

# EOF
```

## Motioneye on DietPi v8.5.x (Raspberry Pi ARMv6 or ARMv7)

Website:

* [Motioneye](https://github.com/ccrisan/motioneye)
* [DietPi](https://dietpi.com/)

Script: [`motioneye_install.sh`](src/motioneye_install.sh)

This script permit to install Motioneye and Tailscale on your Raspberry Pi with DietPi OS. The supported version are:

* ARMv6 32-bit
* ARMv7 32-bit

Please visit the DietPi website to collect more info to install and configure your Raspberry Pi.

* Install DietPi OS on your Raspberry Pi.
* Connect via ssh to your Raspberry Pi where DietPi is installed (eg.: `ssh root@192.168.1.50`)
* Switch to `root` user.
* Run the command:

```
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/main/src/motioneye_install.sh -o /tmp/motioneye_install.sh && bash /tmp/motioneye_install.sh
```

* Reboot your Raspberry Pi (with the command: `reboot`).
* Connect via ssh to your Raspberry Pi where DietPi is installed (eg.: `ssh root@192.168.1.50`)
* Connect local Motioneye website (eg.: `http://192.168.1.50:8765`). Remember to use the port: `8765`.
* To install Rclone follow this guide: [Rclone on MotioneyeOS and Motioneye DietPi](#rclone-on-motioneyeos-and-motioneye-dietpi)

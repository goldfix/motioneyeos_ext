# motioneyeos_ext
A small set of scripts useful to add specific functionalities to Motioneyeos (tested on Raspberry Pi, but I think is possible to use on other versions of Motioneyeos)

### Tailscale

Website: [Tailscale](https://tailscale.com/)

Script: `S98tailscale`

To install or update Tailscale:

- Install Motioneyeos (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation))
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command:
```
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/main/S98tailscale -o /tmp/S98tailscale && bash /tmp/S98tailscale install
```
- Reboot your Raspberry Pi (with the command: `reboot`).
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command: `tailscale up` and configure using your Tailscale credentials.

### Rclone

Website: [Rclone](https://rclone.org/)

Script: `rclone.sh`

To install or update Rclone:

- Install Motioneyeos on your Raspberry Pi (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation))
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command:
```
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/main/rclone_tool.sh -o /tmp/rclone_tool.sh && bash /tmp/rclone_tool.sh install
```
- Reboot your Raspberry Pi (with the command: `reboot`).
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Configure Rclone: `rclone_tool config`

#### Parameters

`rclone_tool install`: installs Rclone on your device. The destination folder of Rclone and configuration files will be: `/usr/bin/`.

`rclone_tool config`: configures Rclone, remote and local folders. The configuration procedure has two different steps. The first step configures Rclone and the second step configures the local camera folder and remote folder.

`rclone_tool run <NAME_DEST>`: runs Rclone. Requires the destination Rclone configuration (same used to configure it). This command is useful to be configured and scheduled with `cron`.

Two different configuration files  will be create after configuration:
- `/usr/bin/rclone.config`: contains the credentials to access to remote folder.
- `/usr/bin/rclone_local.config`: contains the local data camera folder and remote folder. This file is used from command: `rclone_tool run <NAME_DEST>`.

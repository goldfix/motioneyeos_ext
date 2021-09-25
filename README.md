# motioneyeos_ext
A small set of scripts useful to add specific functionalities to Motioneyeos (tested on Raspberry Pi, but I think is possible to use on other versions of Motioneyeos)

### Tailscale

Website: [Tailscale](https://tailscale.com/)

Script: `S98tailscale`

To install or update Tailscale:

- Install Motioneyeos (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation))
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command:
```bash
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/v_1_0/src/S98tailscale -o /tmp/S98tailscale && bash /tmp/S98tailscale install
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
```bash
curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/v_1_0/src/rclone.sh -o /tmp/rclone.sh && bash /tmp/rclone.sh install
```
- Configure Rclone: `rclone config`

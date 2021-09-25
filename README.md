# motioneyeos_ext
A small set of scripts useful to add specific functionalities to Motioneyeos (version for Raspberry Pi)

### Tailscale

Website: [Tailscale](https://tailscale.com/)

Init Script: `S98tailscale`

- Install Motioneyeos (follow this guide: [https://github.com/ccrisan/motioneyeos/wiki/Installation](https://github.com/ccrisan/motioneyeos/wiki/Installation))
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command: `curl -L https://raw.githubusercontent.com/goldfix/motioneyeos_ext/v_1_0/src/S98tailscale -o /tmp/S98tailscale && bash /tmp/S98tailscale install`
- Reboot your Raspberry Pi (with the command: `reboot`).
- Connect via ssh to your Raspberry Pi where Motioneyeos is installed (eg.: `ssh admin@192.168.1.50`)
- Run the command: `tailscale up` and configure using your Tailscale credentials.

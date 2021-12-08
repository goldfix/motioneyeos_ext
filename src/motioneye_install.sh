#!/bin/bash

set -e -o pipefail

echo ------------------------------------------------------------------------
read -n 1 -r -s -p $'This procedure will install motioneye & tailscale. Press CTRL+C to break.\n'

# Install Motioneye
apt-get update && apt-get -y upgrade
mkdir -p /var/log/motion
touch /var/log/motion/motion.log
apt-get install motion ffmpeg v4l-utils -y
systemctl stop motion
systemctl disable motion

apt-get install python2 -y
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output /tmp/get-pip.py
python2 /tmp/get-pip.py

apt install build-essential -y
apt-get install python-dev-is-python2 python-setuptools curl libssl-dev libcurl4-openssl-dev libjpeg-dev zlib1g-dev libffi-dev libzbar-dev libzbar0 -y

pip install motioneye

mkdir -p /etc/motioneye
cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
mkdir -p /var/lib/motioneye
cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
systemctl daemon-reload
systemctl enable motioneye
systemctl start motioneye

pip install motioneye --upgrade
systemctl restart motioneye

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh -o /tmp/install.sh
chmod ugo+x /tmp/install.sh
/tmp/install.sh

echo Tailscale: installation complete! Log in to start using Tailscale by running: 'tailscale up'
echo Motioneye: with your browser try to connect to: \"$(hostname -I)\"

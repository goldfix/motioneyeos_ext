#!/bin/bash

set -e -o pipefail

MACHINE_TYPE=$(arch)||true

echo ------------------------------------------------------------------------
read -n 1 -r -s -p $'This procedure will install motioneye & tailscale. Press CTRL+C to break.\n'

# Install Motioneye
apt update
if [ "${MACHINE_TYPE}" = "x86_64" ]
then
   sudo apt --no-install-recommends install ca-certificates curl python3 python3-dev libcurl4-openssl-dev gcc libssl-dev
fi
apt --no-install-recommends install ca-certificates curl python3 python3-distutils

curl -sSfO 'https://bootstrap.pypa.io/get-pip.py'
python3 get-pip.py
rm get-pip.py
printf '%b' '[global]\nextra-index-url=https://www.piwheels.org/simple/\n' | sudo tee /etc/pip.conf > /dev/null

python3 -m pip install 'https://github.com/motioneye-project/motioneye/archive/dev.tar.gz'
motioneye_init

# Update..
# systemctl stop motioneye
# python3 -m pip install --upgrade --force-reinstall --no-deps 'https://github.com/motioneye-project/motioneye/archive/dev.tar.gz'
# systemctl start motioneye

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh -o /tmp/install.sh
chmod ugo+x /tmp/install.sh
/tmp/install.sh

echo Tailscale: installation complete! Log in to start using Tailscale by running: 'tailscale up'
echo Motioneye: with your browser try to connect to: \"$(hostname -I)\"

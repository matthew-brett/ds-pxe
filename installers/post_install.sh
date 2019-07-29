#!/bin/bash
# Post install scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DS_USER=dataphile

# Update all packages
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove

source ${SCRIPT_DIR}/install_r_packages.sh

# Copy desktop icons
cp -r ${SCRIPT_DIR}/Desktop /home/${DS_USER}
chown -r ${DS_USER}:${DS_USER} /home/${DS_USER}/Desktop

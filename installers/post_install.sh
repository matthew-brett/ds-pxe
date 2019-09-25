#!/bin/bash
# Post install scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DS_USER=dataphile

# Update all packages
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove

# Make desktop directory
DS_HOME="/home/${DS_USER}"
DS_DESKTOP="${DS_HOME}/Desktop"
sudo -u ${DS_USER} mkdir ${DS_DESKTOP}

# Copy generic shortcuts
cp ${SCRIPT_DIR}/Desktop/firefox.desktop ${DS_DESKTOP}
cp ${SCRIPT_DIR}/Desktop/lxterminal.desktop ${DS_DESKTOP}

source ${SCRIPT_DIR}/install_anaconda.sh

# Set permissions on Desktop directory
chown -R ${DS_USER}:${DS_USER} ${DS_DESKTOP}

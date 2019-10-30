#!/bin/bash
# Post install scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DS_USER=dataphile

# Update all packages
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove

# Make desktop and downloads directory
DS_HOME="/home/${DS_USER}"
DS_DESKTOP="${DS_HOME}/Desktop"
DS_DOWNLOADS="${DS_HOME}/Downloads"
sudo -u ${DS_USER} mkdir ${DS_DESKTOP}
sudo -u ${DS_USER} mkdir ${DS_DOWNLOADS}

# Copy generic shortcuts
cp ${SCRIPT_DIR}/Desktop/firefox.desktop ${DS_DESKTOP}
cp ${SCRIPT_DIR}/Desktop/lxterminal.desktop ${DS_DESKTOP}
cp ${SCRIPT_DIR}/Desktop/fileman.desktop ${DS_DESKTOP}
cp ${SCRIPT_DIR}/Desktop/connecting_to_wifi.pdf ${DS_DESKTOP}

# Make shortcut to wifi certificate
sudo -u ${DS_USER} ln -s /etc/ssl/certs/QuoVadis_Root_CA_2.pem ${DS_DOWNLOADS}

source ${SCRIPT_DIR}/install_r_packages.sh

# Set permissions on Desktop directory
chown -R ${DS_USER}:${DS_USER} ${DS_DESKTOP}

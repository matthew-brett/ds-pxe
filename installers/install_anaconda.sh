# Installer from:
# https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh

sudo -u ${DS_USER} mkdir /home/${DS_USER}/.conda
sudo -u ${DS_USER} sh ${SCRIPT_DIR}/Anaconda*.sh -b
sudo echo 'export PATH=$HOME/anaconda3/bin:$PATH' >> /home/${DS_USER}/.bashrc
cp ${SCRIPT_DIR}/Desktop/jupyter.desktop ${DS_DESKTOP}
sudo -u ${DS_USER} mkdir ${DS_DESKTOP}/Notebooks

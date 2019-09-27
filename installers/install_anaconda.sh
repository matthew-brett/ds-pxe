# Installer from:
# https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh

sudo -u ${DS_USER} mkdir /home/${DS_USER}/.conda
sudo -u ${DS_USER} sh ${SCRIPT_DIR}/Anaconda*.sh -b -p ${DS_HOME}/anaconda3
sudo echo 'export PATH=$HOME/anaconda3/bin:$PATH' >> ${DS_HOME}/.bashrc
cp ${SCRIPT_DIR}/Desktop/jupyter.desktop ${DS_DESKTOP}
sudo -u ${DS_USER} mkdir ${DS_DESKTOP}/Notebooks

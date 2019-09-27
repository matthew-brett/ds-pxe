# Installer from:
# https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh

ANACONDA_DIR=${DS_HOME}/anaconda3
sudo -u ${DS_USER} mkdir /home/${DS_USER}/.conda
# We apparently need root to run the installer, at this stage.
# Otherwise I get a permission error in multiprocessing.
sh ${SCRIPT_DIR}/Anaconda*.sh -b -p ${ANACONDA_DIR}
# Set permissions on directory.
chown -R ${DS_USER}:${DS_USER} ${ANACONDA_DIR}
sudo echo 'export PATH=$HOME/anaconda3/bin:$PATH' >> ${DS_HOME}/.bashrc
cp ${SCRIPT_DIR}/Desktop/jupyter.desktop ${DS_DESKTOP}
sudo -u ${DS_USER} mkdir ${DS_DESKTOP}/Notebooks

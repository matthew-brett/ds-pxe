#!/bin/bash
# Install R Studio and notebook packages
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
# https://biostatsr.blogspot.com/2019/01/install-rstudio-11463-in-ubuntu-1804-32.html
wget http://gb.archive.ubuntu.com/ubuntu/pool/universe/g/gstreamer0.10/libgstreamer0.10-0_0.10.36-1.5ubuntu1_i386.deb
apt install -f -y ./libgstreamer0.10-0_0.10.36-1.5ubuntu1_i386.deb
apt-mark hold libgstreamer0.10
wget http://security.ubuntu.com/ubuntu/pool/universe/g/gst-plugins-base0.10/libgstreamer-plugins-base0.10-0_0.10.36-2ubuntu0.2_i386.deb
apt install -f -y ./libgstreamer-plugins-base0.10-0_0.10.36-2ubuntu0.2_i386.deb
apt-mark hold libgstreamer-plugins-base0.10-0
sudo apt install -f -y ./rstudio*.deb
# Set default CRAN source
echo 'options("repos"="https://cran.rstudio.com")' > ~/.Rprofile
# Install packages for R notebook
sudo Rscript -e "install.packages(c('rmarkdown', 'rprojroot'))"

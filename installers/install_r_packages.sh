#!/bin/bash
# Install R Studio and notebook packages
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Install any debs in thid directory
sudo apt install -f -y ${SCRIPT_DIR}/*.deb
# Set default CRAN source
echo 'options("repos"="http://cran.rstudio.com")' > ~/.Rprofile
# Install packages for R notebook
sudo Rscript -e "install.packages(c('rmarkdown', 'rprojroot'))"

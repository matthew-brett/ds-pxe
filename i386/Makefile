NETBOOT_IMG_URL=http://gb.archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-i386/current/images/netboot/ubuntu-installer/i386
INSTALL_DIR=${PWD}/lubuntu-install-i386
INSTALLERS_TAR_PATH=$(INSTALL_DIR)/installers.tar

# For Mac
all: kernel-images $(INSTALLERS_TAR_PATH)

weblinks:
	sudo ln -s $(INSTALL_DIR) /Library/WebServer/Documents

$(INSTALL_DIR)/linux:
	curl -L $(NETBOOT_IMG_URL)/linux > $(INSTALL_DIR)/linux

$(INSTALL_DIR)/initrd.gz:
	curl -L $(NETBOOT_IMG_URL)/initrd.gz > $(INSTALL_DIR)/initrd.gz

kernel-images: $(INSTALL_DIR)/linux $(INSTALL_DIR)/initrd.gz

$(INSTALLERS_TAR_PATH):
	cd installers && \
		rm -f *.deb && \
		curl -LO http://download1.rstudio.org/rstudio-1.1.463-i386.deb && \
		tar cLf $(INSTALLERS_TAR_PATH) *

clean:
	rm -rf $(INSTALL_DIR)/initrd.gz
	rm -rf $(INSTALL_DIR)/linux
	rm -rf $(INSTALLERS_TAR_PATH)

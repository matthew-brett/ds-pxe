SYSLINUX_VERSION=6.03
ARCHIVES=${PWD}/archives
SYSLINUX_ROOT=syslinux-$(SYSLINUX_VERSION)
SYSLINUX_DIR=$(ARCHIVES)/$(SYSLINUX_ROOT)
SYSLINUX_BIOS_DIR=$(SYSLINUX_DIR)/bios
NETBOOT_IMG_URL=http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64
INSTALL_DIR=${PWD}/lubuntu-install
INSTALLERS_TAR_PATH=$(INSTALL_DIR)/installers.tar


# For Mac
all: tftpboot-files kernel-images $(INSTALLERS_TAR_PATH)

weblinks:
	sudo ln -s $(INSTALL_DIR) /Library/WebServer/Documents
	sudo ln -s ${PWD}/tftpboot /private/tftpboot

$(SYSLINUX_BIOS_DIR):
	curl -L https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-$(SYSLINUX_VERSION).tar.gz > $(ARCHIVES)/$(SYSLINUX_ROOT).tar.gz
	cd $(ARCHIVES) && tar xf $(SYSLINUX_ROOT).tar.gz

tftpboot-files: $(SYSLINUX_BIOS_DIR)
	cp $(SYSLINUX_BIOS_DIR)/core/lpxelinux.0 tftpboot/
	cp $(SYSLINUX_BIOS_DIR)/com32/menu/menu.c32 tftpboot/
	cp $(SYSLINUX_BIOS_DIR)/com32/libutil/libutil.c32 tftpboot/
	cp $(SYSLINUX_BIOS_DIR)/com32/elflink/ldlinux/ldlinux.c32 tftpboot/

$(INSTALL_DIR)/linux:
	curl -L $(NETBOOT_IMG_URL)/linux > $(INSTALL_DIR)/linux

$(INSTALL_DIR)/initrd.gz:
	curl -L $(NETBOOT_IMG_URL)/initrd.gz > $(INSTALL_DIR)/initrd.gz

kernel-images: $(INSTALL_DIR)/linux $(INSTALL_DIR)/initrd.gz

$(INSTALLERS_TAR_PATH):
	cd installers && \
		curl -LO https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh && \
		tar cf $(INSTALLERS_TAR_PATH) *

clean:
	rm -rf $(ARCHIVES)/* $(INSTALLERS_TAR_PATH)

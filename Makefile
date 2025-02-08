build    = $(shell git rev-list HEAD --count)
flake    = .
hostname = $(shell hostname)
options  = --option eval-cache false --fallback --print-build-logs --verbose --option extra-experimental-features pipe-operators

build: verify check

android:
	nix-on-droid switch --flake $(flake)
	cp ~/.Wallpaper /sdcard/Download/Wallpaper.jpg
	cp ~/.Wallpaper /sdcard/Download/Wallpaper.png

boot:
	nixos-rebuild boot $(options) --flake $(flake)

cached:
	$(eval options := $(subst eval-cache false,eval-cache true,$(options)))

check: format
	nix flake check --show-trace

format:
	treefmt --no-cache --clear-cache

nixconf:
	mv /etc/nix/nix.conf_ /etc/nix/nix.conf || true

gc:
	nix-collect-garbage -d
	nix store gc
	nix-store --gc

.PHONY: home
home:
	home-manager switch -b old --flake $(flake)#$$USER

housekeep:
	git gc --aggressive --no-cruft --prune=now
	git fsck

# SOURCE: https://github.com/DeterminateSystems/nix-installer
install-system:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

install-user:
	curl -L https://nixos.org/nix/install | sh /dev/stdin --no-daemon
	mkdir -p $$HOME/.config/nix
	printf "experimental-features = nix-command flakes" > $$HOME/.config/nix/nix.conf

install-hm:
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

# Required env variables set:
# INSTALL_HOST       - Host name to install.
# INSTALL_TARGET     - Drive to install to.
# INSTALL_ENCRYPTION - Set any value to enable encryption.
# Must have Internet connection and running from the live iso.
install-nixos:
	@test -f host/*/"${INSTALL_HOST}"/default.nix || { \
		_error "\$$INSTALL_HOST not found or not specified."; \
		exit 2; \
	};
	@test -e "${INSTALL_TARGET}" || { \
		_error "\$$INSTALL_TARGET not found or not specified."; \
		exit 2; \
	};
	@[ $$(nmcli networking connectivity check) = "full" ] || { \
		_error "No internet connection!"; \
		exit 2; \
	};
	@printf "%s\n%s: %s\n%s: %s\n%s: %s\n" \
		"Summary" \
		"Target" "${INSTALL_TARGET}" \
		"Host" "${INSTALL_HOST}" \
		"Encryption" $$([ -z ${INSTALL_ENCRYPTION} ] && echo No || echo Yes)
	@printf "%s" "Press Enter to continue, <C-c> to cancel."
	@read
	# Pre-configure.
	@$(eval zfs_encryption := $(shell [ -z ${INSTALL_ENCRYPTION} ] || echo "-O encryption=on -O keyformat=passphrase -O keylocation=prompt"))
	@$(eval install_flake := $(shell realpath .))
	# Partition.
	parted -s "${INSTALL_TARGET}" mktable gpt
	parted -s "${INSTALL_TARGET}" mkpart primary 0% 1GB
	parted -s "${INSTALL_TARGET}" mkpart primary 1GB 100%
	parted -s "${INSTALL_TARGET}" name 1 NIXBOOT
	parted -s "${INSTALL_TARGET}" name 2 NIXROOT
	parted -s "${INSTALL_TARGET}" set 1 esp on
	# Format.
	mkfs.fat -F 32 /dev/disk/by-partlabel/NIXBOOT
	zpool create -f ${zfs_encryption} -O compression=lz4 -O mountpoint=none -O xattr=sa -O acltype=posixacl -O atime=off system /dev/disk/by-partlabel/NIXROOT
	zfs create -o mountpoint=legacy system/root
	zfs create -o mountpoint=legacy system/nix
	zfs create -o mountpoint=legacy system/var
	zfs create -o mountpoint=legacy system/home
	zfs create -o refreservation=10G -o mountpoint=none system/reserved
	# Configure zfs.
	zfs set com.sun:auto-snapshot:daily=true system
	zfs set com.sun:auto-snapshot:hourly=true system/home
	zfs set com.sun:auto-snapshot:frequent=true system/home
	# Mount.
	mkdir -p /mnt/root
	mount -t zfs system/root /mnt
	mkdir -p /mnt/boot /mnt/nix /mnt/var /mnt/home
	mount -t zfs system/nix /mnt/nix
	mount -t zfs system/var /mnt/var
	mount -t zfs system/home /mnt/home
	mount /dev/disk/by-partlabel/NIXBOOT /mnt/boot
	# Install.
	cd /mnt && nixos-install --no-root-password --no-channel-copy --flake "${install_flake}#${INSTALL_HOST}" || { \
		umount /mnt/boot; \
		umount /mnt/nix; \
		umount /mnt/var; \
		umount /mnt/home; \
		umount /mnt; \
		zpool export system; \
	};

iso-installer:
	nix build -o iso/installer $(options) $(flake)#nixosConfigurations.installer.config.system.build.isoImage

iso-isolation:
	nix build -o iso/isolation $(options) $(flake)#nixosConfigurations.isolation.config.system.build.isoImage

iso-live:
	nix build -o iso/live $(options) $(flake)#nixosConfigurations.live.config.system.build.isoImage

iso-recovery:
	nix build -o iso/recovery $(options) $(flake)#nixosConfigurations.recovery.config.system.build.isoImage

no-nixconf:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_ || true

reboot: boot
	reboot

show:
	nix flake show

switch:
	nixos-rebuild switch $(options) --flake $(flake)

# NOTE: Use `nix flake update <INPUT>` for selective update.
update:
	nix flake update

verify: housekeep
	git verify-commit HEAD

vm:
	nix run $(options) $(flake)#nixosConfigurations.$(hostname).config.system.build.vm

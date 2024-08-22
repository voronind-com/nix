options = --option eval-cache false --fallback
flake   = .

android:
	nix-on-droid switch --flake $(flake)
	cp ~/.termux/_font.ttf ~/.termux/font.ttf
	cp ~/.termux/_colors.properties ~/.termux/colors.properties
	cp ~/.Wallpaper /sdcard/Download/Wallpaper.jpg

boot:
	nixos-rebuild boot $(options) --flake $(flake)

boot-no-nixconf:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_
	nixos-rebuild boot $(options) --flake $(flake)
	mv /etc/nix/nix.conf_ /etc/nix/nix.conf

check:
	nix flake check

# HACK: https://github.com/nix-community/home-manager/issues/5589
fix-hm-root:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_; \
	systemctl restart home-manager-root.service; \
	mv /etc/nix/nix.conf_ /etc/nix/nix.conf

install-nix:
	sh <(curl -L https://nixos.org/nix/install) --no-daemon

install-hm:
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

.PHONY: live
live:
	nix build -o live $(options) $(flake)#nixosConfigurations.live.config.system.build.isoImage

reboot: boot
	reboot

show:
	nix flake show

switch:
	nixos-rebuild switch $(options) --flake $(flake)

trace:
	nix flake check --show-trace

update:
	nix flake update

verify:
	git verify-commit HEAD

# Untested.
vm:
	nix run $(options) $(flake)#nixosConfigurations.${nixosConfig.networking.hostName}.config.system.build.vm

options  = --option eval-cache false --fallback
flake    = .
hostname = $(shell hostname)

help:
	@printf "Please specify a target.\n"

android:
	nix-on-droid switch --flake $(flake)
	cp ~/.termux/_font.ttf ~/.termux/font.ttf
	cp ~/.termux/_colors.properties ~/.termux/colors.properties
	cp ~/.Wallpaper /sdcard/Download/Wallpaper.jpg

boot:
	nixos-rebuild boot $(options) --flake $(flake)

boot-no-nixconf:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_; \
	nixos-rebuild boot $(options) --flake $(flake); \
	mv /etc/nix/nix.conf_ /etc/nix/nix.conf

check:
	nix flake check --show-trace

# HACK: https://github.com/nix-community/home-manager/issues/5589
fix-hm:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_; \
	systemctl restart home-manager-root.service; \
	systemctl restart home-manager-voronind.service; \
	systemctl restart home-manager-dasha.service; \
	mv /etc/nix/nix.conf_ /etc/nix/nix.conf

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

.PHONY: home
home:
	home-manager switch -b old --flake $(flake)#$$USER

.PHONY: live
live:
	nix build -o live $(options) $(flake)#nixosConfigurations.live.config.system.build.isoImage

reboot: boot
	reboot

show:
	nix flake show

switch:
	nixos-rebuild switch $(options) --flake $(flake)

update:
	nix flake update

verify:
	git verify-commit HEAD

vm:
	nix run $(options) $(flake)#nixosConfigurations.$(hostname).config.system.build.vm

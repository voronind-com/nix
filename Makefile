options  = --option eval-cache false --fallback --print-build-logs --verbose --option extra-experimental-features pipe-operators
flake    = .
hostname = $(shell hostname)

help:
	@printf "Please specify a target.\n"

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

.PHONY: installer
installer:
	nix build -o installer $(options) $(flake)#nixosConfigurations.installer.config.system.build.isoImage

.PHONY: live
live:
	nix build -o installer $(options) $(flake)#nixosConfigurations.live.config.system.build.isoImage

.PHONY: recovery
recovery:
	nix build -o installer $(options) $(flake)#nixosConfigurations.recovery.config.system.build.isoImage

no-nixconf:
	mv /etc/nix/nix.conf /etc/nix/nix.conf_ || true

reboot: boot
	reboot

show:
	nix flake show

switch:
	nixos-rebuild switch $(options) --flake $(flake)

update:
	nix flake update

# NOTE: Run `housekeep` target to fix git fsck issues.
verify: housekeep
	git verify-commit HEAD
	git fsck

vm:
	nix run $(options) $(flake)#nixosConfigurations.$(hostname).config.system.build.vm

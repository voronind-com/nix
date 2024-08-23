{ inputs, lib, ... }: {
	imports = [
		"${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
		"${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

		{ networking.wireless.enable = lib.mkForce false; }

		# Override my settings to allow SSH logins using root password.
		{ services.openssh.settings.PasswordAuthentication = lib.mkForce true; }
		{ services.openssh.settings.PermitRootLogin        = lib.mkForce "yes"; }

		# Disable auto-updates as they are not possible for Live ISO.
		{ module.autoupdate.enable = false; }

		# Base Live images also require the LTS kernel.
		{ module.kernel.latest = false; }

		# Root user setup.
		{ home.nixos.enable = true; }
	];
}

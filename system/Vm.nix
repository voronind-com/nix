{ lib, ... }: {
	# SEE: https://github.com/name-snrl/nixos-configuration/blob/e7f6b0f664dbee82e3bf3e85a98cdc3088abe602/modules/nixos/profiles/system/vm-config.nix#L1
	virtualisation.vmVariant = {
		module = {
			autoupdate.enable     = lib.mkForce false;
			builder.client.enable = lib.mkForce false;
			keyd.enable           = lib.mkForce false;
		};
		virtualisation = {
			cores      = 4;
			diskImage  = null;
			diskSize   = 20 * 1024;
			memorySize = 4  * 1024;
			msize      = 1024 * 1024;
			restrictNetwork = false;
			resolution = {
				x = 1280;
				y = 720;
			};
			sharedDirectories.experiments = {
				source = "$HOME";
				target = "/mnt/home";
			};
		};
	};
}

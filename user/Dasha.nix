{
	lib,
	config,
	...
}: let
	cfg = config.user.dasha;
in {
	options.user.dasha = {
		enable = lib.mkEnableOption "dasha";
	};

	config = lib.mkIf cfg.enable {
		home.nixos.users = [{
			homeDirectory = "/home/dasha";
			username      = "dasha";
		}];
		users.users.dasha = {
			createHome     = true;
			description    = "Daria Dranchak";
			hashedPassword = "$y$j9T$WGMPv/bRhGBUidcZLZ7CE/$raZhwFFdI/XvegVZVHLILJLMiBkOxSErc6gao/Cxt33";
			isNormalUser   = true;
			uid            = 1001;
			extraGroups = [
				"input"
				"keyd"
				"libvirtd"
				"networkmanager"
				"video"
			];
		};
	};
}

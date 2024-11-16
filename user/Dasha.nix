{
	lib,
	config,
	...
}: let
	cfg = config.user;
in {
	options.user.dasha = lib.mkEnableOption "dasha.";

	config = lib.mkIf cfg.dasha {
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

{
	config,
	lib,
	secret,
	...
}: let
	cfg = config.user.voronind;
in {
	options.user.voronind = {
		enable = lib.mkEnableOption "voronind";
	};

	config = lib.mkIf cfg.enable {
		home.nixos.users = [{
			homeDirectory = "/home/voronind";
			username      = "voronind";
		}];
		users.users.voronind = {
			createHome     = true;
			description    = "Dmitry Voronin";
			hashedPassword = secret.hashedPassword;
			isNormalUser   = true;
			uid            = 1000;
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

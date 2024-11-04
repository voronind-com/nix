{
	config,
	lib,
	secret,
	util,
	...
}: let
	cfg = config.user.root;
in {
	options.user.root = {
		enable = lib.mkEnableOption "root";
	};

	config = lib.mkIf cfg.enable {
		users.users.root.hashedPassword = secret.hashedPassword;
		home.nixos.users = [{
			homeDirectory = "/root";
			username      = "root";
		}];
		security.sudo = {
			enable = false;
			extraConfig = util.trimTabs ''
				Defaults rootpw
			'';
		};
	};
}

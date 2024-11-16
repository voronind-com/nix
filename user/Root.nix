{
	config,
	lib,
	secret,
	util,
	...
}: let
	cfg = config.user;
in {
	options.user.root = lib.mkEnableOption "root.";

	config = lib.mkIf cfg.root {
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

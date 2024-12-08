{
	config,
	lib,
	...
}: let
	cfg = config.module.syncthing;
in {
	# NOTE: Access at `http://localhost:8384`.
	options.module.syncthing = {
		enable = lib.mkEnableOption "the file sync.";
		dataDir = lib.mkOption {
			default = "/home/${cfg.user}/sync";
			type    = lib.types.str;
		};
		settings = lib.mkOption {
			default = { };
			type    = lib.types.attrs;
		};
		user = lib.mkOption {
			default = "voronind";
			type    = lib.types.str;
		};
		group = lib.mkOption {
			default = "users";
			type    = lib.types.str;
		};
		openDefaultPorts = lib.mkOption {
			default = true;
			type    = lib.types.bool;
		};
	};
}

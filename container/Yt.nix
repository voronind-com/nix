{
	__findFile,
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg = config.container.module.yt;
in {
	options.container.module.yt = {
		enable = lib.mkEnableOption "the YouTube frontend.";
		address = lib.mkOption {
			default = "10.1.0.19";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 3000;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "yt.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/yt";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		containers.yt = container.mkContainer cfg {
			config = { ... }: container.mkContainerConfig cfg {
				services.invidious = {
					enable = true;
					domain = cfg.domain;
					port   = cfg.port;
					nginx.enable = false;
					database = {
						host = config.container.module.postgres.address;
						port = config.container.module.postgres.port;
						createLocally = false;
						passwordFile  = "${pkgs.writeText "InvidiousDbPassword" "invidious"}";
					};
					settings = {
						captcha_enabled      = false;
						check_tables         = true;
						external_port        = 443;
						https_only           = true;
						registration_enabled = false;
						admins = [
							"root"
						];
					};
				};
			};
		};
	};
}

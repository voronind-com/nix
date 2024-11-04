{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.change;
in {
	options.container.module.change = {
		enable = lib.mkEnableOption "the change detection service";
		address = lib.mkOption {
			default = "10.1.0.41";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 5000;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "change.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/change";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.change = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/changedetection-io" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.changedetection-io = {
					enable        = true;
					baseURL       = cfg.domain;
					behindProxy   = true;
					listenAddress = cfg.address;
				};
			};
		};
	};
}

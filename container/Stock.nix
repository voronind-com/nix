{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.stock;
in {
	options.container.module.stock = {
		enable = lib.mkEnableOption "the stock management.";
		address = lib.mkOption {
			default = "10.1.0.45";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 80;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "stock.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/stock";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.stock = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/grocy" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.grocy = {
					enable   = true;
					dataDir  = "/var/lib/grocy";
					hostName = cfg.domain;
					nginx = {
						enableSSL = false;
					};
					settings = {
						calendar = {
							firstDayOfWeek = 1;
							showWeekNumber = true;
						};
						culture  = "en";
						currency = "RUB";
					};
				};
			};
		};
	};
}

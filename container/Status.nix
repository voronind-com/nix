{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.status;
in {
	options.container.module.status = {
		enable = lib.mkEnableOption "the status monitor.";
		address = lib.mkOption {
			default = "10.1.0.22";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 3001;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "status.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/status";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.status = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/uptime-kuma" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				networking = {
					nameservers = lib.mkForce [
						config.container.module.dns.address
					];
				};

				services.uptime-kuma = {
					enable = true;
					settings = {
						DATA_DIR = "/var/lib/uptime-kuma/";
						HOST     = cfg.address;
						PORT     = toString cfg.port;
					};
				};

				systemd.services.uptime-kuma = {
					serviceConfig = {
						DynamicUser = lib.mkForce false;
					};
				};
			};
		};
	};
}

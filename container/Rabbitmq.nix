{
	config,
	container,
	lib,
	pkgs,
	util,
	...
}: let
	cfg = config.container.module.rabbitmq;
in {
	options.container.module.rabbitmq = {
		enable = lib.mkEnableOption "the mqtt server.";
		address = lib.mkOption {
			default = "10.1.0.28";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 5672;
			type    = lib.types.int;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/rabbitmq";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.rabbitmq = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/rabbitmq" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.rabbitmq = {
					enable = true;
					dataDir       = "/var/lib/rabbitmq";
					listenAddress = cfg.address;
					port          = cfg.port;
					configItems = {
						"loopback_users" = "none";
					};
				};
			};
		};
	};
}

{
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg = config.container.module.paper;
in {
	options.container.module.paper = {
		enable = lib.mkEnableOption "the paper scans manager.";
		address = lib.mkOption {
			default = "10.1.0.40";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 28981;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "paper.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/paper";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.paper = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/paperless" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
				"/var/lib/paperless/media" = {
					hostPath   = "${lib.elemAt config.container.media.paper 0}";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.paperless = {
					enable = true;
					address      = "0.0.0.0";
					dataDir      = "/var/lib/paperless";
					port         = cfg.port;
					passwordFile = pkgs.writeText "PaperlessPassword" "root"; # NOTE: Only for initial setup, change later.
					settings = {
						PAPERLESS_ADMIN_USER   = "root";
						PAPERLESS_DBENGINE     = "postgresql";
						PAPERLESS_DBHOST       = config.container.module.postgres.address;
						PAPERLESS_DBNAME       = "paperless";
						PAPERLESS_DBPASS       = "paperless";
						PAPERLESS_DBPORT       = config.container.module.postgres.port;
						PAPERLESS_DBUSER       = "paperless";
						PAPERLESS_OCR_LANGUAGE = "rus";
						PAPERLESS_REDIS        = "redis://${config.container.module.redis.address}:${toString config.container.module.redis.port}";
						PAPERLESS_URL          = "https://${cfg.domain}";
					};
				};

				# HACK: This is required for TCP postgres connection.
				systemd = {
					services = {
						paperless-scheduler = {
							serviceConfig.PrivateNetwork = lib.mkForce false;
							wantedBy = lib.mkForce [ ];
						};
						paperless-consumer = {
							serviceConfig.PrivateNetwork = lib.mkForce false;
							wantedBy = lib.mkForce [ ];
						};
						paperless-web = {
							wantedBy = lib.mkForce [ ];
						};
						paperless-task-queue = {
							wantedBy = lib.mkForce [ ];
						};
					};
					timers.fixsystemd = {
						timerConfig = {
							OnBootSec = 5;
							Unit = "paperless-web.service";
						};
						wantedBy = [
							"timers.target"
						];
					};
				};
			};
		};
	};
}

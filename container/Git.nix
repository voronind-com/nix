{
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg = config.container.module.git;
in {
	options.container.module.git = {
		enable = lib.mkEnableOption "the git server.";
		address = lib.mkOption {
			default = "10.1.0.8";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 3000;
			type    = lib.types.int;
		};
		portSsh = lib.mkOption {
			default = 22144;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "git.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/git";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.git = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/forgejo" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				environment.systemPackages = with pkgs; [
					forgejo
				];

				services.forgejo = {
					enable = true;
					stateDir = "/var/lib/forgejo";

					database = let
						postgre = config.container.module.postgres;
					in {
						createDatabase = false;
						host = postgre.address;
						name = "forgejo";
						port = postgre.port;
						type = "postgres";
						user = "forgejo";
					};

					settings = let
						gcArgs = "--aggressive --no-cruft --prune=now";
						gcTimeout = 600;
					in {
						"cron.cleanup_actions".ENABLED = true;
						"cron.update_mirrors".SCHEDULE = "@midnight";
						"git".GC_ARGS    = gcArgs;
						"git.timeout".GC = gcTimeout;
						"log".LEVEL = "Error";
						"repo-archive".ENABLED = false;
						"repository.issue".MAX_PINNED = 99999;
						"repository.pull-request".DEFAULT_MERGE_STYLE = "rebase";
						"service".DISABLE_REGISTRATION = true;
						"server" = {
							DOMAIN    = cfg.domain;
							HTTP_ADDR = cfg.address;
							ROOT_URL  = "https://${cfg.domain}";
							BUILTIN_SSH_SERVER_USER = "git";
							DISABLE_SSH             = false;
							SSH_PORT                = cfg.portSsh;
							START_SSH_SERVER        = true;
						};
						"ui" = {
							AMBIGUOUS_UNICODE_DETECTION = false;
						};
						"repository" = {
							DEFAULT_PRIVATE = "private";
							DEFAULT_PUSH_CREATE_PRIVATE = true;
						};
						"cron" = {
							ENABLED      = true;
							RUN_AT_START = true;
						};
						"cron.git_gc_repos" = {
							ENABLED  = true;
							ARGS     = gcArgs;
							SCHEDULE = "@midnight";
							TIMEOUT  = gcTimeout;
						};
					};
				};

				systemd = {
					services = {
						forgejo = {
							serviceConfig.PrivateNetwork = lib.mkForce false;
							wantedBy = lib.mkForce [ ];
						};
					};
					timers.fixsystemd = {
						timerConfig = {
							OnBootSec = 5;
							Unit = "forgejo.service";
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

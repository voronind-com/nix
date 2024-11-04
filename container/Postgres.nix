{
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg = config.container.module.postgres;
in {
	options.container.module.postgres = {
		enable = lib.mkEnableOption "the PostgreSQL server.";
		address = lib.mkOption {
			default = "10.1.0.3";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 5432;
			type    = lib.types.int;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/postgres";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.postgres = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/postgresql/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.postgresql = let
					# Populate with services here.
					configurations = with config.container.module; {
						forgejo    = git;
						invidious  = yt;
						mattermost = chat;
						nextcloud  = cloud;
						onlyoffice = office;
						paperless  = paper;
						privatebin = paste;
					};

					access = configurations // {
						all.address = config.container.host;
					};

					authentication = let
						rules = lib.mapAttrsToList (db: cfg:
							"host ${db} ${db} ${cfg.address}/32 trust"
						) access;
					in builtins.foldl' (acc: item: acc + "${item}\n") "" rules;

					ensureDatabases = [
						"root"
					] ++ lib.mapAttrsToList (name: _: name) configurations;

					ensureUsers = map (name: {
						inherit name;
						ensureDBOwnership = true;
						ensureClauses = if name == "root" then {
							createdb   = true;
							createrole = true;
							superuser  = true;
						} else { };
					}) ensureDatabases;
				in {
					inherit authentication ensureDatabases ensureUsers;

					enable = true;
					dataDir     = "/var/lib/postgresql/data/14";
					enableTCPIP = true;
					package     = pkgs.postgresql_14;

					# NOTE: Debug mode.
					# settings = {
					#   log_connections    = true;
					#   log_destination    = lib.mkForce "syslog";
					#   log_disconnections = true;
					#   log_statement      = "all";
					#   logging_collector  = true;
					# };
				};
			};
		};
	};
}

{
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg      = config.container.module.cloud;
	postgres = config.container.module.postgres;
	proxy    = config.container.module.proxy;
in {
	options.container.module.cloud = {
		enable = lib.mkEnableOption "the file cloud service.";
		address = lib.mkOption {
			default = "10.1.0.13";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 80;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "cloud.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/cloud";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.cloud = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/nextcloud" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { config, ... }: container.mkContainerConfig cfg {
				services.nextcloud = {
					enable   = true;
					hostName = cfg.domain;
					# package = pkgs.nextcloud29;
					# phpOptions = {
					#   memory_limit = lib.mkForce "20G";
					# };
					config = {
						adminpassFile = "${pkgs.writeText "NextcloudPassword" "root"}";
						adminuser     = "root";
						dbhost        = postgres.address;
						dbname        = "nextcloud";
						dbpassFile    = "${pkgs.writeText "NextcloudDbPassword" "nextcloud"}";
						dbtype        = "pgsql";
						dbuser        = "nextcloud";
					};
					extraApps = {
						inherit (config.services.nextcloud.package.packages.apps)
							contacts calendar onlyoffice;
					};
					extraAppsEnable = true;
					settings = {
						allow_local_remote_servers = true;
						trusted_domains = [
							cfg.address
							cfg.domain
						];
						trusted_proxies = [
							proxy.address
						];
					};
				};
			};
		};
	};
}

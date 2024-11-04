{
	__findFile,
	config,
	container,
	lib,
	pkgs,
	util,
	...
} @args: let
	cfg     = config.container.module.paste;
	package = (pkgs.callPackage <package/privatebin> args);
in {
	options.container.module.paste = {
		enable = lib.mkEnableOption "the text share platform.";
		address = lib.mkOption {
			default = "10.1.0.14";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 80;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "paste.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/paste";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"config"
			"data"
			"nginxtmp"
			"tmp"
		];

		containers.paste = container.mkContainer cfg {
			bindMounts = {
				"/srv/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
				"/tmp" = {
					hostPath   = "${cfg.storage}/tmp";
					isReadOnly = false;
				};
				"/var/lib/nginx/tmp" = {
					hostPath   = "${cfg.storage}/nginxtmp";
					isReadOnly = false;
				};
				"/srv/config" = {
					hostPath   = "${cfg.storage}/config";
					isReadOnly = false;
				};
			};

			config = { config, ... }: container.mkContainerConfig cfg {
				environment.systemPackages = [
					package
				];
				systemd.packages = [
					package
				];

				users.users.paste = {
					group        = "nginx";
					isSystemUser = true;
				};

				services = {
					phpfpm.pools.paste = {
						group = "nginx";
						user  = "paste";
						phpPackage = pkgs.php;
						settings = {
							"catch_workers_output"       = true;
							"listen.owner"               = "nginx";
							"php_admin_flag[log_errors]" = true;
							"php_admin_value[error_log]" = "stderr";
							"pm"                         = "dynamic";
							"pm.max_children"            = "32";
							"pm.max_requests"            = "500";
							"pm.max_spare_servers"       = "4";
							"pm.min_spare_servers"       = "2";
							"pm.start_servers"           = "2";
						};
						phpEnv = {
							# CONFIG_PATH = "${package}/cfg"; # NOTE: Not working?
						};
					};

					nginx = {
						enable = true;
						virtualHosts.${cfg.domain} = container.mkServer {
							default = true;
							root    = "${package}";
							locations = {
								"/".extraConfig = util.trimTabs ''
									rewrite ^ /index.php;
								'';

								"~ \\.php$".extraConfig = util.trimTabs ''
									fastcgi_split_path_info ^(.+\.php)(/.+)$;
									fastcgi_pass unix:${config.services.phpfpm.pools.paste.socket};
									include ${config.services.nginx.package}/conf/fastcgi.conf;
									include ${config.services.nginx.package}/conf/fastcgi_params;
								'';

								"~ \\.(js|css|ttf|woff2?|png|jpe?g|svg)$".extraConfig = util.trimTabs ''
									add_header Cache-Control "public, max-age=15778463";
									add_header Referrer-Policy no-referrer;
									add_header X-Content-Type-Options nosniff;
									add_header X-Download-Options noopen;
									add_header X-Permitted-Cross-Domain-Policies none;
									add_header X-Robots-Tag none;
									add_header X-XSS-Protection "1; mode=block";
									access_log off;
								'';
							};

							extraConfig = util.trimTabs ''
								try_files $uri /index.php;
							'';
						};
					};
				};
			};
		};
	};
}

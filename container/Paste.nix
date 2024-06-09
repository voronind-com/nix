{ pkgs, util, container, ... } @args: let
	cfg = container.config.paste;
	package = (pkgs.callPackage ./pastebin args);
in {
	systemd.tmpfiles.rules = container.mkContainerDir cfg [
		"data"
		"tmp"
		"nginxtmp"
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
			environment.systemPackages = [ package ];
			systemd.packages = [ package ];

			users.users.paste = {
				group        = "nginx";
				isSystemUser = true;
			};

			services.phpfpm.pools.paste = {
				user  = "paste";
				group = "nginx";

				phpPackage = pkgs.php;

				settings = {
					"pm"                         = "dynamic";
					"php_admin_value[error_log]" = "stderr";
					"php_admin_flag[log_errors]" = true;
					"listen.owner"               = "nginx";
					"catch_workers_output"       = true;
					"pm.max_children"            = "32";
					"pm.start_servers"           = "2";
					"pm.min_spare_servers"       = "2";
					"pm.max_spare_servers"       = "4";
					"pm.max_requests"            = "500";
				};

				phpEnv = {
					# CONFIG_PATH = "${package}/cfg";
				};
			};

			services.nginx = {
				enable = true;
				virtualHosts.${cfg.domain} = container.mkServer {
					default = true;
					root = "${package}";

					locations = {
						"/".extraConfig = ''
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
							add_header X-Content-Type-Options nosniff;
							add_header X-XSS-Protection "1; mode=block";
							add_header X-Robots-Tag none;
							add_header X-Download-Options noopen;
							add_header X-Permitted-Cross-Domain-Policies none;
							add_header Referrer-Policy no-referrer;
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
}
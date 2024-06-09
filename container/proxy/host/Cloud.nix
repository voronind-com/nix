{ domain, util, container, ... }: let
	cfg  = container.config.cloud;
	name = "cloud";
in {
	${cfg.domain} = container.mkServer {
		extraConfig = util.trimTabs ''
			listen 443 ssl;
			set ''$${name} ${cfg.address}:${toString cfg.port};

			location ~ ^/(settings/admin|settings/users|settings/apps|login|api) {
				allow ${container.localAccess};
				allow ${container.config.vpn.address};
				deny all;
				proxy_pass http://''$${name}$request_uri;
			}

			location / {
				proxy_pass http://''$${name}$request_uri;
			}

			ssl_certificate /etc/letsencrypt/live/${domain}/fullchain.pem;
			ssl_certificate_key /etc/letsencrypt/live/${domain}/privkey.pem;
			include /etc/letsencrypt/conf/options-ssl-nginx.conf;
			ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
		'';
	};
}

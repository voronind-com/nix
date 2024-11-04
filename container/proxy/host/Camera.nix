{
	config,
	container,
	util,
	...
}: let
	address = "192.168.2.249";
	domain  = "camera.${config.container.domain}";
	port    = 554;
in {
	${domain} = container.mkServer {
		extraConfig = util.trimTabs ''
			listen 443 ssl;

			location / {
				allow ${config.container.localAccess};
				allow ${config.container.module.status.address};
				allow ${config.container.module.vpn.address};
				allow ${config.container.module.frkn.address};
				deny all;
				return 301 rtsp://${address}:${toString port}/live/main;
			}

			ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
			ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
			include /etc/letsencrypt/conf/options-ssl-nginx.conf;
			ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
		'';
	};
}

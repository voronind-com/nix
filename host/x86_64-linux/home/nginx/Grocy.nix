{
	config,
	lib,
	util,
	...
}: {
	"stock.voronind.com" = {
		locations."~ \\.php$".extraConfig = lib.mkForce (util.trimTabs ''
			allow 10.0.0.0/8;
			allow fd09:8d46:b26::/48;
			deny all;

			fastcgi_split_path_info ^(.+\.php)(/.+)$;
			fastcgi_pass unix:${config.services.phpfpm.pools.grocy.socket};
			include ${config.services.nginx.package}/conf/fastcgi.conf;
			include ${config.services.nginx.package}/conf/fastcgi_params;
		'');

		extraConfig = lib.mkForce (util.trimTabs ''
			listen 443 ssl;

			ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
			ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
			include /etc/letsencrypt/conf/options-ssl-nginx.conf;
			ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;

			try_files $uri /index.php;
		'');
	};
}

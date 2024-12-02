{
	config,
	util,
	...
}: {
	"paste.voronind.com" = {
		locations = {
			"= /".extraConfig = util.trimTabs ''
				return 403;
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

			"/".extraConfig = util.trimTabs ''
				rewrite ^ /index.php;
			'';
		};

		extraConfig = util.trimTabs ''
			listen 443 ssl;
			ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
			ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
			include /etc/letsencrypt/conf/options-ssl-nginx.conf;
			ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
			try_files $uri /index.php;
		'';
	};
}

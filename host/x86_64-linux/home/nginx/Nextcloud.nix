{
	util,
	...
}: {
	"cloud.voronind.com" = {
		locations."~ ^/(settings/admin|settings/users|settings/apps|login|api)".extraConfig = util.trimTabs ''
			allow 10.0.0.0/8;
			allow fd09:8d46:b26::/48;
			deny all;
			try_files $uri $uri/ /index.php$request_uri;
		'';

		extraConfig = util.trimTabs ''
			listen 443 ssl;

			ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
			ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
			include /etc/letsencrypt/conf/options-ssl-nginx.conf;
			ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
		'';
	};
}

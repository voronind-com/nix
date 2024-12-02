{
	util,
	...
}: {
	"print.voronind.com".extraConfig = util.trimTabs ''
		listen 443 ssl;

		location / {
			allow 10.0.0.0/8;
			allow fd09:8d46:b26::/48;
			deny all;

			proxy_pass http://127.0.0.1:631$request_uri;

			proxy_set_header Host "127.0.0.1";
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
		}

		ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
		ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
		include /etc/letsencrypt/conf/options-ssl-nginx.conf;
		ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
	'';
}

{
	util,
	...
}: {
	"yt.voronind.com".extraConfig = util.trimTabs ''
		listen 443 ssl;

		location / {
			allow 10.0.0.0/8;
			allow fd09:8d46:b26::/48;
			deny all;

			proxy_pass http://127.0.0.1:3001$request_uri;

			proxy_set_header X-Forwarded-For $remote_addr;
			proxy_set_header Host $host;
			proxy_http_version 1.1;
			proxy_set_header Connection "";

			proxy_hide_header Content-Security-Policy;
			proxy_hide_header X-Frame-Options;
			proxy_hide_header X-Content-Type-Options;
		}

		ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
		ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
		include /etc/letsencrypt/conf/options-ssl-nginx.conf;
		ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
	'';
}

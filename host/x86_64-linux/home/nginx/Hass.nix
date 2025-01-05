{ ... }:
{
  "iot.voronind.com".extraConfig = ''
    listen 443 ssl;

    location / {
      allow 10.0.0.0/8;
      allow fd09:8d46:b26::/48;
      deny all;

      # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $host;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";

      proxy_pass http://[::1]:8123$request_uri;
    }

    ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
    include /etc/letsencrypt/conf/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
  '';
}

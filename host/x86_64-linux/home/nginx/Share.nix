{ ... }:
{
  "share.voronind.com".extraConfig = ''
    listen 443 ssl;

    location ~* /$ {
      allow 10.0.0.0/8;
      allow fd09:8d46:b26::/48;
      deny all;

      autoindex on;
      root /storage/hot/share;
    }

    location / {
      autoindex off;
      root /storage/hot/share;
    }

    ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
    include /etc/letsencrypt/conf/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
  '';
}

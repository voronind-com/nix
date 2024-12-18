{ ... }:
{
  "camera.voronind.com".extraConfig = ''
    listen 443 ssl;

    location / {
      allow 10.0.0.0/8;
      allow fd09:8d46:b26::/48;
      deny all;
      return 301 rtsp://10.0.0.12:554/live/main;
    }

    ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
    include /etc/letsencrypt/conf/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
  '';
}

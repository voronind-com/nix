{ lib, ... }:
{
  "office.voronind.com" = {
    locations."/".extraConfig = lib.mkForce ''
      add_header X-Forwarded-Proto https;
      proxy_pass http://127.0.0.1:8000$request_uri;
    '';

    extraConfig = ''
      listen 443 ssl;

      ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

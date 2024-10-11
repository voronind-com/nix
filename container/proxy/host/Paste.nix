{ container, config, ... }:
let
  cfg = config.container.module.paste;
  name = "paste";
in
{
  ${cfg.domain} = container.mkServer {
    extraConfig = ''
      listen 443 ssl;
      set ''$${name} ${cfg.address}:${toString cfg.port};

      location = / {
        return 403;
      }

      location / {
        proxy_pass http://''$${name}$request_uri;
      }

      ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

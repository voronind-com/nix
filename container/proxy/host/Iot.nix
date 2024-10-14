{ container, config, ... }:
let
  cfg = config.container.module.iot;
  name = "iot";
in
{
  ${cfg.domain} = container.mkServer {
    extraConfig = ''
      listen 443 ssl;
      set ''$${name} ${cfg.address}:${toString cfg.port};

      location / {
        allow ${config.container.localAccess};
        allow ${config.container.module.status.address};
        allow ${config.container.module.vpn.address};
        allow ${config.container.module.frkn.address};
        deny all;

        # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_pass http://''$${name}$request_uri;
      }

      ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

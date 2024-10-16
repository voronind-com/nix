{ container, config, ... }:
let
  address = "10.0.0.2";
  domain = "router.${config.container.domain}";
  port = 80;
  name = "router";
in
{
  ${domain} = container.mkServer {
    extraConfig = ''
      listen 443 ssl;
      set ''$${name} ${address}:${toString port};

      location / {
        allow ${config.container.localAccess};
        allow ${config.container.module.status.address};
        allow ${config.container.module.vpn.address};
        allow ${config.container.module.frkn.address};
        deny all;
        proxy_pass http://''$${name}$request_uri;
      }

      ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

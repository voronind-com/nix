{ container, config, ... }:
let
  domain = "resume.${config.container.domain}";
  name = "resume";
in
{
  ${domain} = container.mkServer {
    extraConfig = ''
      server_name ${domain};
      listen 443 ssl;

      ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;

      if ($http_accept_language ~ ru) {
        return 301 https://${config.container.module.git.domain}/voronind/resume/releases/download/latest/VoronindRu.pdf;
      }

      return 301 https://${config.container.module.git.domain}/voronind/resume/releases/download/latest/VoronindEn.pdf;
    '';
  };
}

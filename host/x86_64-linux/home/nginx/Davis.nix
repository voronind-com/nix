{ config, ... }:
{
  "dav.${config.const.host.domain}" = {
    inherit (config.const.host) sslCertificate sslCertificateKey;
    locations."/".extraConfig = ''
      allow 10.0.0.0/8;
      allow fd09:8d46:b26::/48;
      deny all;
    '';
    extraConfig = ''
      listen 443 ssl;
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

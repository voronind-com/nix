{ lib, ... }:
{
  "dav.voronind.com" = {
    sslCertificate = "/etc/letsencrypt/live/voronind.com/fullchain.pem";
    sslCertificateKey = "/etc/letsencrypt/live/voronind.com/privkey.pem";
    onlySSL = lib.mkForce true;
    locations."/".extraConfig = ''
      allow 10.0.0.0/8;
      allow fd09:8d46:b26::/48;
      deny all;
    '';
    extraConfig = ''
      include /etc/letsencrypt/conf/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
    '';
  };
}

{ secret, ... }:
{
  config.module.const.host = {
    download = "/hot/download";
    ftp = "/hot/ftp";
    share = "/hot/share";
    sync = "/data/sync";
    noreply = "noreply@voronind.com";
    admin = "admin@voronind.com";
    nginx = {
      domain = "voronind.com";
      sslCertificate = "/etc/letsencrypt/live/voronind.com/fullchain.pem";
      sslCertificateKey = "/etc/letsencrypt/live/voronind.com/privkey.pem";
      allowLocal = ''
        allow 10.0.0.0/8;
        allow ${secret.network.ula};
        allow 127.0.0.1/32;
        allow ::1/128;
        deny all;
      '';
      extraConfig = ''
        listen 443 ssl;
        include /etc/letsencrypt/conf/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;
      '';
    };
  };
}

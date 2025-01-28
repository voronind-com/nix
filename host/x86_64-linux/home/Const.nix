{ config, ... }:
{
  config.module.const.host = {
    data = "/storage/hot_2/data";
    download = "/storage/hot_1/download";
    ftp = "/storage/hot_1/ftp";
    share = "/storage/hot_1/share";
    sync = "/storage/hot_2/sync";
    nginx = {
      domain = "voronind.com";
      sslCertificate = "/etc/letsencrypt/live/voronind.com/fullchain.pem";
      sslCertificateKey = "/etc/letsencrypt/live/voronind.com/privkey.pem";
      allowLocal = ''
        allow 10.0.0.0/8;
        allow ${config.module.const.ula};
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

{ ... }: {
  config.const.host = {
    domain = "voronind.com";
    sslCertificate = "/etc/letsencrypt/live/voronind.com/fullchain.pem";
    sslCertificateKey = "/etc/letsencrypt/live/voronind.com/privkey.pem";
  };
}

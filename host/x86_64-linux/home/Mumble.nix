{ config, ... }:
{
  services.murmur = {
    enable = true;
    clientCertRequired = true;
    environmentFile = "${config.services.murmur.stateDir}/Env";
    port = 22666;
    registerHostname = "chat.voronind.com";
    sslCert = "/etc/letsencrypt/live/voronind.com/fullchain.pem";
    sslKey = "/etc/letsencrypt/live/voronind.com/privkey.pem";
  };
}

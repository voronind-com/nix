{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "camera.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      extraConfig = cfg.allowLocal;
      return = "301 rtsp://10.0.0.12:554/live/main";
    };
  };
}

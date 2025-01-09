{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "download.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8112$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

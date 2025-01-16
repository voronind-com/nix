{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "paper.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:28981$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

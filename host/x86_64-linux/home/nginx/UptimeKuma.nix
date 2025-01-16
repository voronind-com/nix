{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "status.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:64901$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "paste.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/".extraConfig = cfg.allowLocal;
  };
}

{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "read.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:5000$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

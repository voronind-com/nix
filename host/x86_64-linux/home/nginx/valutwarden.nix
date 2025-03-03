{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "pass.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:8001$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

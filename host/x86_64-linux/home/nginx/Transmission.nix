{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "download.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:9091$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

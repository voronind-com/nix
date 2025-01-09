{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "search.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:34972$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

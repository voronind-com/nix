{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "watch.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:8096$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "irc.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:9000$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

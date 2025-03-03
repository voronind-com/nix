{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "printer.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[fd09:8d46:b26:0:9e1c:37ff:fe62:3fd5]:80$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

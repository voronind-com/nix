{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "router.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[fd09:8d46:b26:0:9e9d:7eff:fe8e:3dc7]:80$request_uri";
      extraConfig = cfg.allowLocal;
    };
  };
}

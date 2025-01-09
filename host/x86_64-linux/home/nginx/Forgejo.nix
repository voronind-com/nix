{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "git.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations = {
      "~ ^/(admin|api|user)" = {
        extraConfig = cfg.allowLocal;
        proxyPass = "http://[::1]:3000$request_uri";
      };
      "/".proxyPass = "http://[::1]:3000$request_uri";
    };
  };
}

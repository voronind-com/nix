{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "craft.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:33122$request_uri";
      recommendedProxySettings = false;
      extraConfig =
        cfg.allowLocal
        + ''
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Proto https;
        '';
    };
  };
}

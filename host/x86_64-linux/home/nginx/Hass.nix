{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "iot.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:8123$request_uri";
      recommendedProxySettings = false;
      extraConfig = cfg.allowLocal + ''
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
      '';
    };
  };
}

{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "sync.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:8384$request_uri";
      extraConfig =
        cfg.allowLocal
        + ''
          proxy_set_header Host "localhost";
          proxy_set_header X-Forwarded-Host "localhost";
        '';
    };
  };
}

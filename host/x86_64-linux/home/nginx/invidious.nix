{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "yt.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://[::1]:3001$request_uri";
      extraConfig =
        cfg.allowLocal
        + ''
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header Host $host;
          proxy_http_version 1.1;
          proxy_set_header Connection "";
          proxy_hide_header Content-Security-Policy;
          proxy_hide_header X-Frame-Options;
          proxy_hide_header X-Content-Type-Options;
        '';
    };
  };
}

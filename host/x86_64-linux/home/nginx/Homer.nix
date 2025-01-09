{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "home.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      tryFiles = "$uri $uri/index.html";
      extraConfig =
        cfg.allowLocal
        + ''
          proxy_set_header Host "127.0.0.1";
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
        '';
    };
  };
}

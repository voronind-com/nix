{ config, ... }:
let
  cfg = config.const.host.nginx;
in
{
  "change.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/" = {
      proxyPass = "http://127.0.0.1:5001$request_uri";
      extraConfig =
        cfg.allowLocal
        + ''
          add_header Referrer-Policy 'origin';
        '';
    };
  };
}

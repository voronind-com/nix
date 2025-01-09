{ config, ... }:
let
  cfg = config.const.host.nginx;
  root = "/storage/hot/share";
in
{
  "share.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations = {
      # "~* /$" = {
      "= /" = {
        inherit root;
        extraConfig =
          cfg.allowLocal
          + ''
            autoindex on;
          '';
      };
      "/" = {
        inherit root;
        extraConfig = ''
          autoindex off;
        '';
      };
    };
  };
}

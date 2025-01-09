{ config, ... }:
let
  cfg = config.const.host.nginx;
  root = "/storage/hot/share";
  index = ''
    autoindex on;
    charset UTF-8;
  '';
in
{
  "share.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations = {
      # "~* /$" = {
      "= /" = {
        inherit root;
        extraConfig = index + cfg.allowLocal;
      };
      "/" = {
        inherit root;
        extraConfig = index;
      };
    };
  };
}

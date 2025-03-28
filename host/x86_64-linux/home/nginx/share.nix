{ config, ... }:
let
  cfg = config.module.const.host.nginx;
  root = config.module.const.host.share;
  index = ''
    autoindex on;
    charset UTF-8;
  '';
in
{
  "share.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations = {
      "~* /$" = {
        # "= /" = {
        inherit root;
        extraConfig = index + cfg.allowLocal;
      };
      "= /favicon.ico" = {
        return = "301 https://upload.wikimedia.org/wikipedia/commons/f/ff/Sharethis.svg";
      };
      "/" = {
        inherit root;
        extraConfig = index;
      };
    };
  };
}

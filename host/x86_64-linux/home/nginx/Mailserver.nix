{ config, lib, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "mail.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey;
    enableACME = false;
    forceSSL = false;
    extraConfig = lib.mkForce cfg.extraConfig;
    locations."~* \\.php(/|$)".extraConfig = cfg.allowLocal;
  };
}

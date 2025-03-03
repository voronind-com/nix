{ config, ... }:
let
  cfg = config.module.const.host.nginx;
in
{
  "resume.${cfg.domain}" = {
    inherit (cfg) sslCertificate sslCertificateKey extraConfig;
    locations."/".extraConfig =
      cfg.allowLocal
      + ''
        if ($http_accept_language ~ ru) {
          return 301 https://git.voronind.com/voronind/resume/releases/download/latest/VoronindRu.pdf;
        }
        return 301 https://git.voronind.com/voronind/resume/releases/download/latest/VoronindEn.pdf;
      '';
  };
}

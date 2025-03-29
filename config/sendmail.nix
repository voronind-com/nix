{ config, lib, ... }:
let
  cfg = config.module.sendmail;
  user = "noreply@voronind.com";
  host = config.networking.hostName;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.msmtp = {
        enable = true;
        setSendmail = true;
        accounts.default = {
          host = "smtp.voronind.com";
          tls = true;
          tls_certcheck = false;  # ISSUE: Does not accept LE cert with `The certificate issuer is unknown` error.
          tls_starttls = false;
          auth = true;
          port = 465;
          inherit user;
          from = "System at ${host} <${user}>";
          passwordeval = "cat ${config.age.secrets.noreply-password.path}";
        };
      };
    })

    (lib.mkIf cfg.public {
      # NOTE: Allow normal users to send mails.
      age.secrets.noreply-password.mode = "444";
    })
  ];
}

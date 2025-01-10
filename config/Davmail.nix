{ config, lib, ... }:
let
  cfg = config.module.davmail;
in
{
  config = lib.mkIf cfg.enable {
    services.davmail = {
      enable = true;
      url = "https://mail.fsight.ru/ews/exchange.asmx";
      config = {
        davmail.server = true;
        davmail.allowRemote = false;
        davmail.bindAddress = "::1";
        davmail.imapPort = 55143;
        davmail.smtpPort = 55025;
        davmail.caldavPort = 55080;
      };
    };
  };
}

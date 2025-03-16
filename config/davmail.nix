# This awesome piece of software lets me use corporate Exchange mail
# as a proper IMAP protocol.
{ config, lib, ... }:
let
  cfg = config.module.davmail;
in
{
  config = lib.mkIf cfg.enable {
    services.davmail = {
      enable = true;
      url = "https://mail.fsight.ru/ews/exchange.asmx";
      config.davmail = {
        server = true;
        allowRemote = false;
        bindAddress = "::1";
        imapPort = 55143;
        smtpPort = 55025;
        caldavPort = 55080;
      };
    };
  };
}

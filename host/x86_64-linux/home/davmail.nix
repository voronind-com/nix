{ ... }:
{
  services.davmail = {
    enable = true;
    url = "https://mail.fsight.ru/ews/exchange.asmx";
    config = {
      davmail.server = true;
      davmail.allowRemote = true;
      davmail.bindAddress = "::";
      davmail.imapPort = 55143;
      davmail.smtpPort = 55025;
      davmail.caldavPort = 55080;
    };
  };
}

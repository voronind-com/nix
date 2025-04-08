{
  services.davmail = {
    enable = true;
    url = "https://mail.fsight.ru/ews/exchange.asmx";
    config = {
      davmail = {
        server = true;
        allowRemote = true;
        bindAddress = "::";
        imapPort = 55143;
        smtpPort = 55025;
        caldavPort = 55080;
      };
    };
  };
}

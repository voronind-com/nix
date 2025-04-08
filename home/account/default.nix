_:
let
  mkMail = cfg: cfg // { thunderbird.enable = true; };

  mkHomeMail =
    cfg:
    mkMail (
      cfg
      // {
        imap = {
          host = "mail.voronind.com";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "mail.voronind.com";
          port = 465;
          tls.enable = true;
        };
      }
    );

  mkWorkMail =
    cfg:
    mkMail (
      cfg
      // {
        imap = {
          host = "localhost";
          port = 55143;
          tls.enable = false;
        };
        smtp = {
          host = "localhost";
          port = 55025;
          tls.enable = false;
        };
      }
    );

  mkHomeCalendar = {
    remote = {
      type = "caldav";
      url = "https://dav.voronind.com";
      userName = "voronind";
    };
  };

  mkWorkCalendar = {
    remote = {
      type = "caldav";
      url = "http://home.local:55080";
      userName = "voronind";
    };
  };

  realName = "Dmitry Voronin";
in
{
  email.accounts = {
    Account = mkHomeMail {
      inherit realName;
      primary = true;
      address = "account@voronind.com";
      userName = "account@voronind.com";
    };
    Personal = mkHomeMail {
      inherit realName;
      address = "hi@voronind.com";
      userName = "hi@voronind.com";
    };
    Admin = mkHomeMail {
      inherit realName;
      address = "admin@voronind.com";
      userName = "admin@voronind.com";
    };
    Job = mkHomeMail {
      inherit realName;
      address = "job@voronind.com";
      userName = "job@voronind.com";
    };
    Trash = mkHomeMail {
      inherit realName;
      address = "trash@voronind.com";
      userName = "trash@voronind.com";
    };
    Work = mkWorkMail {
      inherit realName;
      address = "dd.voronin@fsight.ru";
      userName = "fs\\dd.voronin";
    };
  };

  # ISSUE: https://github.com/nix-community/home-manager/issues/5775
  calendar.accounts = {
    default = mkHomeCalendar // {
      primary = true;
    };
    family = mkHomeCalendar;
    health = mkHomeCalendar;
    high = mkHomeCalendar;
    holiday = mkHomeCalendar;
    low = mkHomeCalendar;
    medium = mkHomeCalendar;
    payment = mkHomeCalendar;
    work = mkHomeCalendar;
    fsight = mkWorkCalendar;
  };

  # ISSUE: https://github.com/nix-community/home-manager/issues/5933
  contact.accounts = {
    Home = {
      remote = {
        type = "carddav";
        url = "https://dav.voronind.com";
        userName = "voronind";
      };
    };
  };
}

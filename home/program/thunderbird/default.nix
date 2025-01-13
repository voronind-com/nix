{
  __findFile,
  config,
  lib,
  pkgs,
  ...
}:
{
  enable = true;
  package = pkgs.thunderbird-esr;
  profiles.default = {
    isDefault = true;
    withExternalGnupg = true;
  };
  settings = {
    "browser.download.useDownloadDir" = true;
    "calendar.alarms.onforevents" = 0;
    "calendar.alarms.onfortodos" = 0;
    "calendar.alarms.show" = true;
    "calendar.alarms.soundType" = 1;
    "calendar.alarms.soundURL" = "file://${<static/Notification.ogg>}";
    "calendar.item.editInTab" = true;
    "calendar.notifications.times" = "-PT5M";
    "calendar.view-minimonth.showWeekNumber" = false;
    "calendar.view.dayendhour" = 19;
    "calendar.view.daystarthour" = 10;
    "font.minimum-size.x-western" = 16;
    "font.size.monospace.x-western" = 16;
    "font.size.variable.x-western" = 16;
    "mail.biff.use_system_alert" = true;
    "mailnews.start_page.enabled" = false;
    "pdfjs.enabledCache.state" = false;
  };

  # ISSUE: https://github.com/nix-community/home-manager/issues/5775
  # ISSUE: https://github.com/nix-community/home-manager/issues/5933
  # settings =
  #   let
  #     safeName = builtins.replaceStrings [ "." ] [ "-" ];
  #
  #     calendarAccounts = lib.mapAttrsToList (n: v: { n = v; }) config.home-manager.users.voronind.accounts.calendar.accounts;
  #     calendars = lib.foldAttrs (
  #       item: acc:
  #       let
  #         calendarAccountSafeName = safeName item.name;
  #       in
  #       acc
  #       // {
  #         "calendar.registry.${calendarAccountSafeName}.cache.enabled" = true;
  #         "calendar.registry.${calendarAccountSafeName}.calendar-main-default" = item.primary;
  #         "calendar.registry.${calendarAccountSafeName}.calendar-main-in-composite" = item.primary;
  #         "calendar.registry.${calendarAccountSafeName}.name" = item.name;
  #         "calendar.registry.${calendarAccountSafeName}.type" = "caldav";
  #         "calendar.registry.${calendarAccountSafeName}.uri" = item.remote.url;
  #         "calendar.registry.${calendarAccountSafeName}.username" = item.remote.userName;
  #       }
  #     ) { } calendarAccounts;
  #
  #     contactsAccount = config.home-manager.users.voronind.accounts.contact.accounts.Home;
  #     contactsAccountSafeName = safeName contactsAccount.name;
  #     addressBookFilename = "abook-${contactsAccountSafeName}.sqlite";
  #   in
  #   calendars
  #   // {
  #     "ldap_2.servers.${contactsAccountSafeName}.carddav.url" = contactsAccount.remote.url;
  #     "ldap_2.servers.${contactsAccountSafeName}.carddav.username" = contactsAccount.remote.userName;
  #     "ldap_2.servers.${contactsAccountSafeName}.description" = contactsAccount.name;
  #     "ldap_2.servers.${contactsAccountSafeName}.dirType" = 102;
  #     "ldap_2.servers.${contactsAccountSafeName}.filename" = addressBookFilename;
  #     "mail.collect_addressbook" = "jscarddav://${addressBookFilename}";
  #   };
}

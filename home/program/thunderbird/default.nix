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
  settings = let
    dayEnd = 19;
    dayStart = 10;
    fontSize = config.module.style.font.size.application;
    reminderMinutes = 10;
    snoozeMinutes = 10;
  in
  {
    "browser.download.useDownloadDir" = true;
    "calendar.alarms.defaultsnoozelength" = snoozeMinutes;
    "calendar.alarms.eventalarmlen" = reminderMinutes;
    "calendar.alarms.onforevents" = 0;
    "calendar.alarms.onfortodos" = 0;
    "calendar.alarms.show" = true;
    "calendar.alarms.soundType" = 1;
    "calendar.alarms.soundURL" = "file://${<static/Notification.ogg>}";
    "calendar.alarms.todoalarmlen" = reminderMinutes;
    "calendar.item.editInTab" = true;
    "calendar.notifications.times" = "-PT${toString reminderMinutes}M";
    "calendar.view-minimonth.showWeekNumber" = false;
    "calendar.view.dayendhour" = dayEnd;
    "calendar.view.daystarthour" = dayStart;
    "font.minimum-size.x-western" = fontSize;
    "font.size.monospace.x-western" = fontSize;
    "font.size.variable.x-western" = fontSize;
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

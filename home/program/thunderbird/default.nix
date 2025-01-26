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
  settings =
    let
      dayEnd = 19;
      dayStart = 10;
      fontSize = 16;
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
}

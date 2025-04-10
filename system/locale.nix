{ config, ... }:
let
  inherit (config.module) purpose;
  # en = "en_US.UTF-8";
  ru = "ru_RU.UTF-8";
  c = "C.UTF-8";

  locale = if purpose.parents then ru else c;
in
{
  environment.variables.LC_ALL = locale;
  time.timeZone = config.module.const.timeZone;
  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };
}

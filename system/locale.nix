{ config, ... }:
let
  purpose = config.module.purpose;
  en = "en_US.UTF-8";
  ru = "ru_RU.UTF-8";
in
{
  time.timeZone = config.module.const.timeZone;
  i18n = {
    defaultLocale = if purpose.parents then ru else en;
    extraLocaleSettings = {
      LC_ADDRESS = ru;
      LC_IDENTIFICATION = ru;
      LC_MEASUREMENT = ru;
      LC_MONETARY = ru;
      LC_NAME = ru;
      LC_NUMERIC = ru;
      LC_PAPER = ru;
      LC_TELEPHONE = ru;
      LC_TIME = ru;
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.parents;
in
{
  config = lib.mkIf cfg.enable {
    # Disable unwanted stuff.
    stylix.enable = lib.mkForce false;
    module = {
      keyd.enable = lib.mkForce false;
      sway.enable = lib.mkForce false;
    };

    # Add KDE.
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    # Russian language.
    i18n =
      let
        ru = "ru_RU.UTF-8";
      in
      {
        defaultLocale = lib.mkForce ru;
        extraLocaleSettings = {
          LC_ADDRESS = lib.mkForce ru;
          LC_IDENTIFICATION = lib.mkForce ru;
          LC_MEASUREMENT = lib.mkForce ru;
          LC_MONETARY = lib.mkForce ru;
          LC_NAME = lib.mkForce ru;
          LC_NUMERIC = lib.mkForce ru;
          LC_PAPER = lib.mkForce ru;
          LC_TELEPHONE = lib.mkForce ru;
          LC_TIME = lib.mkForce ru;
        };
      };

    # Add onlyoffice.
    environment.systemPackages = with pkgs; [ onlyoffice-desktopeditors ];
  };
}

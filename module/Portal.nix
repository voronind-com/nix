# Portals are needed for Wayland apps to select files, screen shares etc.
{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.desktop.portal;
in
{
  options = {
    module.desktop.portal.enable = mkEnableOption "Portals.";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gtk"
            "wlr"
          ];
        };
      };
      wlr.enable = true;
      xdgOpenUsePortal = false;
    };
  };
}

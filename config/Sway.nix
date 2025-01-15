{ config, lib, ... }:
let
  cfg = config.module.sway;
in
{
  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = lib.mkForce false;
    environment.variables.XDG_CURRENT_DESKTOP = "sway";
    module = {
      bluetooth.enable = true;
      brightness.enable = true;
      portal.enable = true;
      sound.enable = true;
      waybar.enable = true;
      wayland.enable = true;
    };
    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
}

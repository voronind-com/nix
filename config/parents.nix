{ config, lib, ... }:
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
  };
}

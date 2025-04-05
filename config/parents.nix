{ config, lib, ... }:
let
  cfg = config.module.parents;
in
{
  config = lib.mkIf cfg.enable {
    # Add KDE.
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    # Auto login.
    services.displayManager.autoLogin = {
      enable = true;
      user = config.user.primary;
    };
  };
}

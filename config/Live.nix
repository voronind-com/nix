{ config, lib, ... }:
let
  cfg = config.module.live;
in
{
  config = lib.mkIf cfg.enable {
    # services.rogue.enable = true; # NOTE: Not available smh.
    services.mingetty = {
      autologinUser = "live";
      helpLine = ''
        Welcome! Both live and root users have password "live". Enjoy!
      '';
    };
  };
}

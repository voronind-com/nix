{ config, lib, ... }:
let
  cfg = config.module.live;
in
{
  config = lib.mkIf cfg.enable {
    # services.rogue.enable = true; # NOTE: Not available smh.
    fileSystems = lib.mkForce config.lib.isoFileSystems;
    boot.zfs.extraPools = lib.mkForce false;
    services = {
      getty = {
        autologinUser = lib.mkForce "live";
        helpLine = ''
          Welcome! Both live and root users have password "live". Enjoy!
        '';
      };
    };
  };
}

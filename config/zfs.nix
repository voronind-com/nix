{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.zfs;
  admin = "admin@voronind.com";
in
{
  config = lib.mkMerge [
    {
      boot.zfs.extraPools = cfg.pools;
      services.zfs.autoScrub.pools = cfg.scrub;
    }
    (lib.mkIf cfg.notify {
      module.sendmail.enable = true;

      services.zfs.zed = {
        enableMail = true;
        settings = {
          ZED_DEBUG_LOG = "/tmp/zed-debug.log";

          ZED_EMAIL_ADDR = [ admin ];
          ZED_EMAIL_PROG = lib.getExe pkgs.msmtp;
          ZED_EMAIL_OPTS = "@ADDRESS@";

          ZED_NOTIFY_INTERVAL_SECS = 3600;
          ZED_NOTIFY_DATA = true;
          ZED_NOTIFY_VERBOSE = true;
        };
      };
    })
  ];
}

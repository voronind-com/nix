{ config, ... }:
let
  cfg = config.module.zfs;
in
{
  config = {
    boot.zfs.extraPools = cfg.pools;
    services.zfs.autoScrub.pools = cfg.scrub;
  };
}

{ ... }:
{
  # systemd.services.jellyfin.serviceConfig.MemoryMax = cfg.memLimit;

  users.users.jellyfin.extraGroups = [
    "video"
    "render"
  ];

  services.jellyfin = {
    enable = true;
    # cacheDir = "/var/cache/jellyfin";
    # dataDir  = "/var/lib/jellyfin";
  };
}

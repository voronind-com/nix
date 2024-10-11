{
  container,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.watch;
in
{
  options = {
    container.module.watch = {
      enable = mkEnableOption "Media server.";
      address = mkOption {
        default = "10.1.0.11";
        type = types.str;
      };
      port = mkOption {
        default = 8096;
        type = types.int;
      };
      domain = mkOption {
        default = "watch.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/watch";
        type = types.str;
      };
      memLimit = mkOption {
        default = "8G";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
      "cache"
    ];

    containers.watch = container.mkContainer cfg {
      bindMounts =
        {
          "/var/lib/jellyfin" = {
            hostPath = "${cfg.storage}/data";
            isReadOnly = false;
          };
          "/var/cache/jellyfin" = {
            hostPath = "${cfg.storage}/cache";
            isReadOnly = false;
          };
          "/dev/dri" = {
            hostPath = "/dev/dri";
            isReadOnly = false;
          };
        }
        // container.attachMedia "anime" true
        // container.attachMedia "download" true
        // container.attachMedia "movie" true
        // container.attachMedia "music" true
        // container.attachMedia "photo" true
        // container.attachMedia "porn" true
        // container.attachMedia "show" true
        // container.attachMedia "study" true
        // container.attachMedia "work" true
        // container.attachMedia "youtube" true;

      allowedDevices = [
        {
          modifier = "rwm";
          node = "/dev/dri/renderD128";
        }
      ];

      config =
        { ... }:
        container.mkContainerConfig cfg {
          # users.users.jellyfin.extraGroups = [
          #   "video"
          #   "render"
          # ];

          services.jellyfin = {
            enable = true;
            cacheDir = "/var/cache/jellyfin";
            dataDir = "/var/lib/jellyfin";
          };

          systemd.services.jellyfin.serviceConfig.MemoryLimit = cfg.memLimit;
        };
    };
  };
}

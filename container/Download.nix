{
  container,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.download;
in
{
  options = {
    container.module.download = {
      enable = mkEnableOption "Downloader.";
      address = mkOption {
        default = "10.1.0.12";
        type = types.str;
      };
      port = mkOption {
        default = 8112;
        type = types.int;
      };
      domain = mkOption {
        default = "download.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/download";
        type = types.str;
      };
      memLimit = mkOption {
        default = "4G";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.download = container.mkContainer cfg {
      enableTun = true;

      bindMounts = {
        "/var/lib/deluge/.config/deluge" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      } // container.attachMedia "download" false;

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.deluge = {
            enable = true;
            dataDir = "/var/lib/deluge";
            web.enable = true;
          };

          systemd.services.deluged.serviceConfig = {
            MemoryLimit = cfg.memLimit;
            Restart = lib.mkForce "always";
            RuntimeMaxSec = "6h";
          };
        };
    };
  };
}

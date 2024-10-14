{
  container,
  pkgs,
  lib,
  config,
  ...
}@args:
with lib;
let
  cfg = config.container.module.cloud;

  postgres = config.container.module.postgres;
  proxy = config.container.module.proxy;
in
{
  options = {
    container.module.cloud = {
      enable = mkEnableOption "File cloud service";
      address = mkOption {
        default = "10.1.0.13";
        type = types.str;
      };
      port = mkOption {
        default = 80;
        type = types.int;
      };
      domain = mkOption {
        default = "cloud.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/cloud";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.cloud = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/nextcloud" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { config, ... }:
        container.mkContainerConfig cfg {
          services.nextcloud = {
            enable = true;
            # package = pkgs.nextcloud29;
            hostName = cfg.domain;
            # phpOptions = {
            #   memory_limit = lib.mkForce "20G";
            # };
            config = {
              adminuser = "root";
              adminpassFile = "${pkgs.writeText "NextcloudPassword" "root"}";

              dbhost = postgres.address;
              dbname = "nextcloud";
              dbpassFile = "${pkgs.writeText "NextcloudDbPassword" "nextcloud"}";
              dbtype = "pgsql";
              dbuser = "nextcloud";
            };
            extraApps = {
              inherit (config.services.nextcloud.package.packages.apps) contacts calendar onlyoffice;
            };
            extraAppsEnable = true;
            settings = {
              trusted_domains = [
                cfg.address
                cfg.domain
              ];
              trusted_proxies = [ proxy.address ];
              allow_local_remote_servers = true;
            };
          };
        };
    };
  };
}

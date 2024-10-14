{
  container,
  pkgs,
  pkgsStable,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.paper;
in
{
  options = {
    container.module.paper = {
      enable = mkEnableOption "Paper scans manager.";
      address = mkOption {
        default = "10.1.0.40";
        type = types.str;
      };
      port = mkOption {
        default = 28981;
        type = types.int;
      };
      domain = mkOption {
        default = "paper.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/paper";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.paper = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/paperless" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
        "/var/lib/paperless/media" = {
          hostPath = "${elemAt config.container.media.paper 0}";
          isReadOnly = false;
        };
      };

      config =
        { lib, ... }:
        container.mkContainerConfig cfg {
          services.paperless = {
            enable = true;
            dataDir = "/var/lib/paperless";
            # address = cfg.domain;
            address = "0.0.0.0";
            port = cfg.port;
            # ISSUE: https://github.com/NixOS/nixpkgs/issues/322596
            # package = pkgsStable.paperless-ngx;
            passwordFile = pkgs.writeText "PaperlessPassword" "root";
            settings = {
              PAPERLESS_URL = "https://${cfg.domain}";
              PAPERLESS_ADMIN_USER = "root";
              PAPERLESS_DBHOST = config.container.module.postgres.address;
              PAPERLESS_DBENGINE = "postgresql";
              PAPERLESS_DBNAME = "paperless";
              PAPERLESS_DBPASS = "paperless";
              PAPERLESS_DBPORT = config.container.module.postgres.port;
              PAPERLESS_DBUSER = "paperless";
              PAPERLESS_OCR_LANGUAGE = "rus";
              PAPERLESS_REDIS = "redis://${config.container.module.redis.address}:${toString config.container.module.redis.port}";
            };
          };

          # HACK: This is required for TCP postgres connection.
          systemd = {
            services = {
              paperless-scheduler = {
                serviceConfig.PrivateNetwork = mkForce false;
                wantedBy = mkForce [ ];
              };
              paperless-consumer = {
                serviceConfig.PrivateNetwork = mkForce false;
                wantedBy = mkForce [ ];
              };
              paperless-web = {
                wantedBy = mkForce [ ];
              };
              paperless-task-queue = {
                wantedBy = mkForce [ ];
              };
            };
            timers.fixsystemd = {
              timerConfig = {
                OnBootSec = 5;
                Unit = "paperless-web.service";
              };
              wantedBy = [ "timers.target" ];
            };
          };
        };
    };
  };
}

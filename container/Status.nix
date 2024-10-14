{
  container,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.status;
in
{
  options = {
    container.module.status = {
      enable = mkEnableOption "Status monitor.";
      address = mkOption {
        default = "10.1.0.22";
        type = types.str;
      };
      port = mkOption {
        default = 3001;
        type = types.int;
      };
      domain = mkOption {
        default = "status.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/status";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.status = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/uptime-kuma" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { lib, ... }:
        container.mkContainerConfig cfg {
          networking = {
            nameservers = mkForce [ config.container.module.dns.address ];
          };

          services.uptime-kuma = {
            enable = true;
            settings = {
              DATA_DIR = "/var/lib/uptime-kuma/";
              HOST = cfg.address;
              PORT = toString cfg.port;
            };
          };

          systemd.services.uptime-kuma = {
            serviceConfig.DynamicUser = mkForce false;
          };
        };
    };
  };
}

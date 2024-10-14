{
  container,
  pkgs,
  util,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.rabbitmq;
in
{
  options = {
    container.module.rabbitmq = {
      enable = mkEnableOption "Mqtt server.";
      address = mkOption {
        default = "10.1.0.28";
        type = types.str;
      };
      port = mkOption {
        default = 5672;
        type = types.int;
      };
      storage = mkOption {
        default = "${config.container.storage}/rabbitmq";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.rabbitmq = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/rabbitmq" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.rabbitmq = {
            enable = true;
            listenAddress = cfg.address;
            port = cfg.port;
            dataDir = "/var/lib/rabbitmq";
            configItems = {
              "loopback_users" = "none";
            };
          };
        };
    };
  };
}

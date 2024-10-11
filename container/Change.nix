{
  container,
  lib,
  config,
  ...
}@args:
with lib;
let
  cfg = config.container.module.change;
in
{
  options = {
    container.module.change = {
      enable = mkEnableOption "Change detection service";
      address = mkOption {
        default = "10.1.0.41";
        type = types.str;
      };
      port = mkOption {
        default = 5000;
        type = types.int;
      };
      domain = mkOption {
        default = "change.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/change";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.change = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/changedetection-io" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.changedetection-io = {
            enable = true;
            baseURL = cfg.domain;
            behindProxy = true;
            listenAddress = cfg.address;
          };
        };
    };
  };
}

{
  container,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.stock;
in
{
  options = {
    container.module.stock = {
      enable = mkEnableOption "Stock management.";
      address = mkOption {
        default = "10.1.0.45";
        type = types.str;
      };
      port = mkOption {
        default = 80;
        type = types.int;
      };
      domain = mkOption {
        default = "stock.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/stock";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.stock = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/grocy" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.grocy = {
            enable = true;
            dataDir = "/var/lib/grocy";
            hostName = cfg.domain;
            nginx.enableSSL = false;
            settings = {
              calendar = {
                firstDayOfWeek = 1;
                showWeekNumber = true;
              };
              culture = "en";
              currency = "RUB";
            };
          };
        };
    };
  };
}

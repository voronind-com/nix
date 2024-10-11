# NOTE: Login to contaier, run passwd and use that root/pw combo for administration. `AllowFrom = all` doesn't seem to work.

# ipp://192.168.2.237
# Pantum M6500W-Series
{
  container,
  pkgs,
  lib,
  config,
  __findFile,
  ...
}@args:
with lib;
let
  cfg = config.container.module.print;
  package = pkgs.callPackage <package/print> args;
  host = config.container.host;
in
{
  options = {
    container.module.print = {
      enable = mkEnableOption "Printing server.";
      address = mkOption {
        default = "10.1.0.46";
        type = types.str;
      };
      port = mkOption {
        default = 631;
        type = types.int;
      };
      domain = mkOption {
        default = "print.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/print";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.print = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/cups" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          networking.interfaces."eth0".ipv4.routes = [
            {
              address = "192.168.2.237";
              prefixLength = 32;
              via = host;
            }
          ];

          services.printing = {
            enable = true;
            allowFrom = [ "all" ];
            browsing = true;
            defaultShared = true;
            drivers = [ package ];
            listenAddresses = [ "${cfg.address}:${toString cfg.port}" ];
            startWhenNeeded = true;
            stateless = false;
            webInterface = true;
          };
        };
    };
  };
}

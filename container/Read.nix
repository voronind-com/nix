{
  container,
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.read;
in
{
  options = {
    container.module.read = {
      enable = mkEnableOption "Reading server.";
      address = mkOption {
        default = "10.1.0.39";
        type = types.str;
      };
      port = mkOption {
        default = 5000;
        type = types.int;
      };
      domain = mkOption {
        default = "read.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/read";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.read = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/kavita" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      } // container.attachMedia "book" true // container.attachMedia "manga" true;

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.kavita = {
            enable = true;
            dataDir = "/var/lib/kavita";
            tokenKeyFile = pkgs.writeText "KavitaToken" "xY19aQOa939/Ie6GCRGbubVK8zRwrgBY/20AuyMpYshUjwK1Uyl7bw1yknVh6jJIFIfwq2vAjeotOUq7NEsf9Q==";
            settings = {
              IpAddresses = cfg.address;
              Port = cfg.port;
            };
          };
        };
    };
  };
}

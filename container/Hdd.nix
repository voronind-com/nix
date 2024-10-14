# ISSUE: Broken, can't read/write sda device.
{
  container,
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.container.module.hdd;
in
{
  options = {
    container.module.hdd = {
      enable = mkEnableOption "Hdd health monitor.";
      address = mkOption {
        default = "10.1.0.10";
        type = types.str;
      };
      port = mkOption {
        default = 8080;
        type = types.int;
      };
      domain = mkOption {
        default = "hdd.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/hdd";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.hdd = container.mkContainer cfg {
      # bindMounts = let
      #   attachDrive = hostPath: {
      #     inherit hostPath;
      #     isReadOnly = false;
      #   };
      # in {
      #   "/opt/scrutiny" = {
      #     hostPath   = "${cfg.storage}/data";
      #     isReadOnly = false;
      #   };
      #   "/dev/sda" = attachDrive "/dev/sda";
      # };

      # allowedDevices = [
      #   {
      #     modifier = "rwm";
      #     node     = "/dev/sda";
      #   }
      # ];

      # additionalCapabilities = [ "CAP_SYS_ADMIN" ];

      config =
        { ... }:
        container.mkContainerConfig cfg {
          environment.systemPackages = with pkgs; [ smartmontools ];

          services.scrutiny = {
            enable = true;
            settings.web = {
              listen = {
                host = cfg.address;
                port = cfg.port;
              };
            };
          };
        };
    };
  };
}

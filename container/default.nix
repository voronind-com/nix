{ lib, config, ... }:
with lib;
let
  cfg = config.container;
in
{
  options = {
    container = {
      enable = mkEnableOption "Containers!!";

      autoStart = mkOption {
        default = false;
        type = types.bool;
      };

      host = mkOption {
        default = "0.0.0.0";
        type = types.str;
      };

      localAccess = mkOption {
        default = "0.0.0.0";
        type = types.str;
      };

      storage = mkOption {
        default = "/tmp/container";
        type = types.str;
      };

      domain = mkOption {
        default = "local";
        type = types.str;
      };

      interface = mkOption {
        default = "lo";
        type = types.str;
      };

      media = mkOption {
        default = { };
        type = types.attrs;
      };
    };
  };

  config = mkIf cfg.enable {
    # This is the network for all the containers.
    # They are not available to the external interface by default,
    # instead they all expose specific ports in their configuration.
    networking = {
      nat = {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = config.container.interface;
      };
      networkmanager.unmanaged = [ "interface-name:ve-*" ];
    };
  };
}

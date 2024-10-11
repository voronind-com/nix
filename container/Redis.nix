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
  cfg = config.container.module.redis;
in
{
  options = {
    container.module.redis = {
      enable = mkEnableOption "Redis server.";
      address = mkOption {
        default = "10.1.0.38";
        type = types.str;
      };
      port = mkOption {
        default = 6379;
        type = types.int;
      };
    };
  };

  config = mkIf cfg.enable {
    containers.redis = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.redis.servers.main = {
            enable = true;
            port = cfg.port;
            bind = cfg.address;
            extraParams = [ "--protected-mode no" ];
          };
        };
    };
  };
}

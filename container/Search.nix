{
  container,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.search;
in
{
  options = {
    container.module.search = {
      enable = mkEnableOption "Search frontend.";
      address = mkOption {
        default = "10.1.0.26";
        type = types.str;
      };
      port = mkOption {
        default = 8080;
        type = types.int;
      };
      domain = mkOption {
        default = "search.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/search";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    containers.search = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.searx = {
            enable = true;
            package = pkgs.searxng;
            settings = {
              server = {
                bind_address = cfg.address;
                port = cfg.port;
                secret_key = "searxxx";
              };
            };
          };
        };
    };
  };
}

{
  container,
  pkgs,
  lib,
  config,
  __findFile,
  ...
}:
with lib;
let
  cfg = config.container.module.yt;
in
{
  options = {
    container.module.yt = {
      enable = mkEnableOption "YouTube frontend.";
      address = mkOption {
        default = "10.1.0.19";
        type = types.str;
      };
      port = mkOption {
        default = 3000;
        type = types.int;
      };
      domain = mkOption {
        default = "yt.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/yt";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    containers.yt = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.invidious = {
            enable = true;
            domain = cfg.domain;
            port = cfg.port;
            nginx.enable = false;
            database = {
              port = config.container.module.postgres.port;
              host = config.container.module.postgres.address;
              createLocally = false;
              passwordFile = "${pkgs.writeText "InvidiousDbPassword" "invidious"}";
            };
            settings = {
              admins = [ "root" ];
              captcha_enabled = false;
              check_tables = true;
              registration_enabled = false;
              external_port = 443;
              https_only = true;
            };
          };
        };
    };
  };
}

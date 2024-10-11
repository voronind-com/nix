{
  container,
  pkgs,
  util,
  lib,
  config,
  __findFile,
  ...
}@args:
with lib;
let
  cfg = config.container.module.home;
  package = (pkgs.callPackage <package/homer> args);
in
{
  options = {
    container.module.home = {
      enable = mkEnableOption "Dashboard.";
      address = mkOption {
        default = "10.1.0.18";
        type = types.str;
      };
      port = mkOption {
        default = 80;
        type = types.int;
      };
      domain = mkOption {
        default = "home.${config.container.domain}";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    containers.home = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          environment.systemPackages = [ package ];
          systemd.packages = [ package ];

          services.nginx = {
            enable = true;
            virtualHosts.${cfg.domain} = container.mkServer {
              default = true;
              root = "${package}";

              locations = {
                "/".extraConfig = ''
                  try_files $uri $uri/index.html;
                '';
              };
            };
          };
        };
    };
  };
}

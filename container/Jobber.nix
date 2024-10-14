{
  container,
  pkgsJobber,
  poetry2nixJobber,
  lib,
  config,
  __findFile,
  ...
}:
with lib;
let
  cfg = config.container.module.jobber;
  script = import <package/jobber> {
    poetry2nix = poetry2nixJobber;
    pkgs = pkgsJobber;
  };
in
{
  options = {
    container.module.jobber = {
      enable = mkEnableOption "Button pusher Stanley.";
      address = mkOption {
        default = "10.1.0.32";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/jobber";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.jobber = container.mkContainer cfg {
      bindMounts = {
        "/data" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = true;
        };
      };

      enableTun = true;

      config =
        { lib, ... }:
        let
          packages =
            [ script ]
            ++ (with pkgsJobber; [
              firefox
              geckodriver
              openvpn
              python311
            ]);
        in
        container.mkContainerConfig cfg {
          networking = lib.mkForce { nameservers = [ "10.30.218.2" ]; };

          systemd.services.jobber = {
            description = "My job is pushing the button.";
            enable = true;
            wantedBy = [ "multi-user.target" ];
            path = packages;
            environment = {
              PYTHONUNBUFFERED = "1";
              PYTHONDONTWRITEBYTECODE = "1";
            };
            serviceConfig = {
              Type = "simple";
              ExecStart = "${script}/bin/jobber -u";
              Restart = "on-failure";
            };
          };
        };
    };
  };
}

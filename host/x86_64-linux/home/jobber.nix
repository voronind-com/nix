# Use `nixos-container login jobber` as root and empty pw.
{
  __findFile,
  config,
  lib,
  pkgsJobber,
  poetry2nix-jobber,
  ...
}:
let
  script = import <package/jobber> {
    pkgs = pkgsJobber;
    poetry2nix = poetry2nix-jobber;
  };
in
{
  networking.nat = {
    enable = true;
    externalInterface = "enp8s0";
    internalInterfaces = [ "ve-+" ];
  };

  containers.jobber = {
    autoStart = true;
    enableTun = true;
    privateNetwork = true;
    hostAddress = "188.242.247.132";
    localAddress = "10.1.0.2";

    bindMounts = {
      "/data" = {
        hostPath = "/data/secret/jobber";
        isReadOnly = true;
      };
    };

    config =
      { ... }:
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
      {
        boot.isContainer = true;
        system.stateVersion = "24.11";
        users = {
          users.root.password = "";
          mutableUsers = false;
        };
        networking = {
          useHostResolvConf = lib.mkForce false;
          nameservers = [ "10.30.218.2" ];
        };

        systemd.services.jobber = {
          description = "My job is pushing the button.";
          enable = true;
          path = packages;
          wantedBy = [ "multi-user.target" ];
          environment = {
            PYTHONDONTWRITEBYTECODE = "1";
            PYTHONUNBUFFERED = "1";
          };
          serviceConfig = {
            ExecStart = "${script}/bin/jobber -u";
            Restart = "on-failure";
            Type = "simple";
          };
        };
      };
  };
}

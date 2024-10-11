# Polkit agent is used by apps to ask for Root password with a popup.
{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.desktop.polkit;
in
{
  options = {
    module.desktop.polkit.enable = mkEnableOption "Polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
    systemd = {
      packages = with pkgs; [
        polkit-kde-agent
      ];
      user = {
        services.plasma-polkit-agent = {
          serviceConfig = {
            Restart = "always";
            RestartSec = 2;
            Slice = "session.slice";
          };
          environment.PATH = mkForce null;
          wantedBy = [ "gui-session.target" ];
        };
      };
    };
  };
}

{
  __findFile,
  config,
  lib,
  pkgs,
  ...
}@args:
let
  cfg = config.module.package;
  package = import <package> args;
in
{
  config = lib.mkMerge [
    # Core apps.
    (lib.mkIf cfg.core {
      environment.systemPackages = package.core;

      programs = {
        adb.enable = true;
        git.enable = true;
        java = {
          enable = true;
          package = pkgs.corretto21;
        };
      };
      services = {
        udisks2.enable = true;
      };
    })

    # Common apps.
    (lib.mkIf cfg.common {
      environment.systemPackages = package.common;
      services.gvfs.enable = true;

      # Chromium config.
      environment.etc =
        let
          chromium = import <home/file/chromium> args;
        in
        {
          "chromium/initial_preferences".source = lib.mkForce chromium.preferences;
          "chromium/policies/managed/extra.json".source = lib.mkForce chromium.policy;
        };
    })

    # Desktop apps.
    (lib.mkIf cfg.desktop { environment.systemPackages = package.desktop; })

    # Gaming.
    (lib.mkIf cfg.gaming {
      programs.steam.enable = true;
      environment.systemPackages = package.gaming;
      hardware.graphics =
        let
          packages = with pkgs; [
            dxvk
            pkgs.mangohud
            vkd3d
          ];
        in
        {
          extraPackages = packages;
          extraPackages32 = packages;
        };
    })

    # Creativity.
    (lib.mkIf cfg.creative { environment.systemPackages = package.creative; })

    # Development.
    (lib.mkIf cfg.dev { environment.systemPackages = package.dev; })

    # Extras.
    (lib.mkIf cfg.extra { environment.systemPackages = package.extra; })
  ];
}

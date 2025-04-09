{
  __findFile,
  config,
  lib,
  pkgs,
  pkgs-unstable,
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

      # Use `file -i file.txt` to find file mime type.
      # Use `xdg-mime query default "text/plain"` to find default app.
      # Desktop files are in `/run/current-system/sw/share/applications`.
      xdg.mime.defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "audio/*" = "mpv.desktop";
        "image/*" = "org.gnome.Loupe.desktop";
        "text/*" = "nvim.desktop";
        "video/*" = "mpv.desktop";
      };
    })

    # Desktop apps.
    (lib.mkIf cfg.desktop { environment.systemPackages = package.desktop; })

    # Gaming.
    (lib.mkIf cfg.gaming {
      programs.steam = {
        enable = true;
        package = pkgs-unstable.steam;
      };
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
    (lib.mkIf cfg.dev {
      environment.systemPackages = package.dev;

      programs = {
        direnv = {
          enable = true;
          silent = true;
          nix-direnv.enable = true;
          direnvrcExtra = ''
            export SHELL_NAME=direnv
          '';
        };
      };
    })

    # Extras.
    (lib.mkIf cfg.extra { environment.systemPackages = package.extra; })
  ];
}

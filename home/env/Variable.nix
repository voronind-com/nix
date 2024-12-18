{ pkgs, ... }:
{
  EDITOR = "nvim"; # Default text editor.
  GTK_CSD = 0; # GTK apps compat.
  MANGOHUD = "1"; # Enable Mangohud by default.
  MANPAGER = "nvim +Man!"; # App to use for man pages.
  MOZ_LEGACY_PROFILES = "1"; # Disable Firefox profile switching on rebuild.
  NIXPKGS_ALLOW_UNFREE = "1"; # Allow unfree packages in shell.
  NIX_CURRENT_SYSTEM = "${pkgs.stdenv.system}"; # Current system architecture.
  TERM = "xterm-256color"; # Terminal settings.
  WINEFSYNC = "1"; # Use fsync for Wine.
}

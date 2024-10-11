# This is a common user configuration.
{
  const,
  pkgs,
  self,
  config,
  lib,
  inputs,
  pkgsStable,
  pkgsMaster,
  __findFile,
  ...
}@args:
with lib;
let
  cfg = config.home.android;
  stylix = import <config/Stylix.nix> args;
  android = import ./android args;
  package = import <package> args;
in
# homePath = "/data/data/com.termux.nix/files/home";
{
  options = {
    home.android = {
      enable = mkEnableOption "Android HM config.";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = const.timeZone;
    environment.packages = package.core;
    home-manager.config = stylix // {
      imports = [ inputs.stylix.homeManagerModules.stylix ];
      home = {
        stateVersion = const.droidStateVersion;
        sessionVariables = import ./variable args;
        file = (import ./config args) // {
          ".termux/_font.ttf".source = android.font;
          ".termux/_colors.properties".text = android.colors;
        };
      };
      programs = import ./program args;
    };
  };
}

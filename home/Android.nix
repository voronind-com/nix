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
    environment.packages = package.core;
    time.timeZone = const.timeZone;

    terminal = {
      inherit (android) font colors;
    };

    home-manager.config = stylix // {
      imports = [ inputs.stylix.homeManagerModules.stylix ];
      home = {
        file = import ./config args;
        sessionVariables = import ./variable args;
        stateVersion = const.droidStateVersion;
      };
      programs = import ./program args;
    };
  };
}

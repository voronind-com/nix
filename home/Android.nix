# This is a common user configuration.
{
  __findFile,
  config,
  const,
  inputs,
  lib,
  pkgs,
  pkgsMaster,
  pkgsUnstable,
  self,
  ...
}@args:
let
  cfg = config.home.android;
  android = import ./android args;
  env = import ./env args;
  file = import ./file args;
  package = import <package> args;
  programs = import ./program args;
  stylix = import <system/Stylix.nix> args;
in
{
  options.home.android = {
    enable = lib.mkEnableOption "the Android HM config.";
  };

  config = lib.mkIf cfg.enable {
    environment.packages = package.core;
    nix.extraOptions = "experimental-features = nix-command flakes pipe-operators";
    system.stateVersion = const.droidStateVersion;
    time.timeZone = const.timeZone;
    terminal = { inherit (android) font colors; };
    home-manager.config = stylix // {
      programs = with programs; core;
      imports = [ inputs.stylix.homeManagerModules.stylix ];
      home = {
        inherit (env) sessionVariables;
        inherit file;
        stateVersion = const.droidStateVersion;
      };
    };
  };
}

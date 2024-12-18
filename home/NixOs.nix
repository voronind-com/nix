# This is a common user configuration.
{
  __findFile,
  config,
  const,
  lib,
  pkgs,
  util,
  ...
}@args:
let
  cfg = config.home.nixos;
  env = import ./env args;
  file = import ./file args;
  programs = import ./program args;
in
{
  imports = (util.ls <user>);

  options.home.nixos = {
    enable = lib.mkEnableOption "the NixOS user setup.";
    users = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf attrs;
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      backupFileExtension =
        "backup-"
        + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { } "echo -n date '+%Y%m%d%H%M%S' > $out"}";
      users = builtins.foldl' (
        acc: user:
        acc
        // {
          ${user.username} = {
            home = {
              inherit (const) stateVersion;
              inherit (env) sessionVariables;
              inherit (user) username homeDirectory;
              inherit file;

              # ISSUE: https://github.com/nix-community/home-manager/issues/5589
              extraActivationPath = with pkgs; [ openssh ];
            };
            xdg = import ./xdg { inherit (user) homeDirectory; };
            programs = with programs; core // desktop;
            dconf.settings = util.catSet (util.ls ./file/dconf) args;
          };
        }
      ) { } cfg.users;
    };
  };
}

# This is a common user configuration.
{
  __findFile,
  config,
  lib,
  pkgs,
  util,
  ...
}@args:
let
  cfg = config.home.nixos;
  env = import ./env args;
  file = import ./file args;
  program = import ./program args;
  purpose = config.module.purpose;
in
{
  imports = (util.ls <user>);

  options.home.nixos = {
    enable = lib.mkEnableOption "the NixOS user setup." // {
      default = with purpose; desktop || laptop || live || server;
    };
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
            accounts = import ./account args;
            dconf.settings = util.catSet (util.ls ./file/dconf) args;
            programs = with program; core // desktop;
            xdg = import ./xdg { inherit (user) homeDirectory; };
            home = {
              inherit (config.module.const) stateVersion;
              inherit (env) sessionVariables;
              inherit (user) username homeDirectory;
              inherit file;

              # ISSUE: https://github.com/nix-community/home-manager/issues/5589
              extraActivationPath = with pkgs; [ openssh ];
            };
          };
        }
      ) { } cfg.users;
    };
  };
}

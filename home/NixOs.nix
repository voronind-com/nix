# This is a common user configuration.
{
  const,
  config,
  util,
  lib,
  pkgs,
  __findFile,
  ...
}@args:
with lib;
let
  cfg = config.home.nixos;
  programs = import ./program args;
in
{
  imports = (util.ls <user>);

  options = {
    home.nixos = {
      enable = mkEnableOption "NixOS user setup.";
      users = mkOption {
        default = [ ];
        type = types.listOf types.attrs;
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      users = builtins.foldl' (
        acc: user:
        acc
        // {
          ${user.username} = {
            home = {
              inherit (const) stateVersion;
              inherit (user) username homeDirectory;
              file = import ./config args;
              sessionVariables = import ./variable args;

              # ISSUE: https://github.com/nix-community/home-manager/issues/5589
              extraActivationPath = with pkgs; [ openssh ];
            };
            xdg = import ./xdg { inherit (user) homeDirectory; };
            programs = with programs; core // desktop;
            dconf.settings = util.catSet (util.ls ./config/dconf) args;
          };
        }
      ) { } cfg.users;

      backupFileExtension =
        "backup-"
        + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { } "echo -n date '+%Y%m%d%H%M%S' > $out"}";
    };
  };
}

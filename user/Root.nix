{
  lib,
  config,
  secret,
  ...
}:
with lib;
let
  cfg = config.user.root;
in
{
  options = {
    user.root = {
      enable = mkEnableOption "root";
    };
  };

  config = mkIf cfg.enable {
    home.nixos.users = [
      {
        username = "root";
        homeDirectory = "/root";
      }
    ];
    users.users.root.hashedPassword = secret.hashedPassword;
    security.sudo = {
      enable = false;
      extraConfig = ''
        Defaults rootpw
      '';
    };
  };
}

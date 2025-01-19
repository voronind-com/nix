{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user;
  purpose = config.module.purpose;
in
{
  options.user.root = lib.mkEnableOption "root." // {
    default = with purpose; desktop || laptop || live || server;
  };

  config = lib.mkIf cfg.root {
    users.users.root.hashedPassword =
      if purpose.live then secret.password.live else secret.password.root;
    home.nixos.users = [
      {
        homeDirectory = "/root";
        username = "root";
      }
    ];
    security.sudo = {
      enable = false;
      extraConfig = ''
        Defaults rootpw
      '';
    };
  };
}

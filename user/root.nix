{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user.user.root;
  purpose = config.module.purpose;
in
{
  options.user.user.root.enable = lib.mkEnableOption "root." // {
    default = with purpose; desktop || laptop || live || server;
  };

  config = lib.mkIf cfg.enable {
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

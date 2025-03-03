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
  options.user.live = lib.mkEnableOption "live user." // {
    default = purpose.live;
  };

  config = lib.mkIf cfg.live {
    home.nixos.users = [
      {
        homeDirectory = "/home/live";
        username = "live";
      }
    ];
    users.users.live = {
      createHome = true;
      description = "Live User";
      hashedPassword = secret.password.live;
      isNormalUser = true;
      uid = 1022;
      extraGroups = [
        "input"
        "keyd"
        "libvirtd"
        "networkmanager"
        "video"
      ];
    };
  };
}

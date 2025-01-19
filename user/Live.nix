{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user;
in
{
  options.user.live = lib.mkEnableOption "live user.";

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

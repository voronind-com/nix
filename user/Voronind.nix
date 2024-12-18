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
  options.user.voronind = lib.mkEnableOption "voronind.";

  config = lib.mkIf cfg.voronind {
    home.nixos.users = [
      {
        homeDirectory = "/home/voronind";
        username = "voronind";
      }
    ];
    users.users.voronind = {
      createHome = true;
      description = "Dmitry Voronin";
      hashedPassword = secret.hashedPassword;
      isNormalUser = true;
      uid = 1000;
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

{
  lib,
  config,
  secret,
  ...
}:
with lib;
let
  cfg = config.user.voronind;
in
{
  options = {
    user.voronind = {
      enable = mkEnableOption "voronind";
    };
  };

  config = mkIf cfg.enable {
    home.nixos.users = [
      {
        username = "voronind";
        homeDirectory = "/home/voronind";
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

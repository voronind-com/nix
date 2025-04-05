{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user.user.voronind;
in
{
  options.user.user.voronind = {
    enable = lib.mkEnableOption "voronind.";
    primary = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.nixos.users = [
      {
        homeDirectory = "/home/voronind";
        username = "voronind";
      }
    ];
    users.users.voronind = {
      createHome = true;
      description = "Dmitry Voronin";
      hashedPassword = secret.password.voronind;
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

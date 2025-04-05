{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user.user.live;
  purpose = config.module.purpose;
in
{
  options.user.user.live = {

    enable = lib.mkEnableOption "live user." // {
      default = purpose.live;
    };
    primary = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
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

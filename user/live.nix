{
  config,
  lib,
  secret,
  ...
}:
let
  inherit (config.module) purpose;
  cfg = config.user.user.live;
in
{
  options.user.user.live.enable = lib.mkEnableOption "live user." // {
    default = purpose.live;
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

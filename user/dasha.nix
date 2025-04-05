{
  config,
  lib,
  pkgs,
  secret,
  ...
}:
let
  cfg = config.user.user.dasha;
in
{
  options.user.user.dasha = {
    enable = lib.mkEnableOption "dasha.";
    primary = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nautilus ]; # NOTE: She wants it.
    home.nixos.users = [
      {
        homeDirectory = "/home/dasha";
        username = "dasha";
      }
    ];
    users.users.dasha = {
      createHome = true;
      description = "Daria Dranchak";
      hashedPassword = secret.password.dasha;
      isNormalUser = true;
      uid = 1001;
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

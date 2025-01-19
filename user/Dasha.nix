{
  config,
  lib,
  pkgs,
  secret,
  ...
}:
let
  cfg = config.user;
in
{
  options.user.dasha = lib.mkEnableOption "dasha.";

  config = lib.mkIf cfg.dasha {
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

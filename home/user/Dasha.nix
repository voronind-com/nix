{ lib, config, ... }:
with lib;
let
  cfg = config.user.dasha;
in
{
  options = {
    user.dasha = {
      enable = mkEnableOption "dasha";
    };
  };

  config = mkIf cfg.enable {
    home.nixos.users = [
      {
        username = "dasha";
        homeDirectory = "/home/dasha";
      }
    ];
    users.users.dasha = {
      createHome = true;
      description = "Daria Dranchak";
      hashedPassword = "$y$j9T$WGMPv/bRhGBUidcZLZ7CE/$raZhwFFdI/XvegVZVHLILJLMiBkOxSErc6gao/Cxt33";
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

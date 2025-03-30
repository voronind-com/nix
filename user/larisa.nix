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
  options.user.larisa = lib.mkEnableOption "larisa.";

  config = lib.mkIf cfg.larisa {
    home.nixos.users = [
      {
        homeDirectory = "/home/larisa";
        username = "larisa";
      }
    ];
    users.users.larisa = {
      createHome = true;
      description = "Larisa Dranchak";
      hashedPassword = secret.password.larisa;
      isNormalUser = true;
      uid = 1002;
      extraGroups = [
        "networkmanager"
        "video"
      ];
    };
  };
}

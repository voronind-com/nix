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
    users.users.larisa = {
      createHome = true;
      description = "Лариса";
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

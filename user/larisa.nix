{
  config,
  lib,
  secret,
  ...
}:
let
  cfg = config.user.user.larisa;
in
{
  options.user.user.larisa = {
    enable = lib.mkEnableOption "larisa.";
    primary = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
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

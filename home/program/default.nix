{
  config,
  lib,
  secret,
  ...
}@args:
let
  bash = import ./bash args;
in
{
  core = {
    home-manager.enable = true;

    gpg = {
      inherit (secret.crypto) publicKeys;
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
      settings = {
        keyserver = "hkps://keys.openpgp.org";
      };
    };

    bash = {
      enable = true;
      initExtra = bash.bashrc;
    };
  };

  desktop = {
    firefox = import ./firefox args;
    thunderbird = import ./thunderbird args;
  };
}

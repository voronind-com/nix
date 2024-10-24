{
  secret,
  lib,
  config,
  ...
}@args:
let
  bash = import ./bash args;
in
{
  core = {
    home-manager.enable = true;

    gpg = {
      enable = true;
      inherit (secret.crypto) publicKeys;
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
  };
}

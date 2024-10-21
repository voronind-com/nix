{ secret, ... }@args:
let
  bash = import ./bash args;
in
{
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

  firefox = import ./firefox args;

  bash = {
    enable = true;
    initExtra = bash.bashrc;
  };
}

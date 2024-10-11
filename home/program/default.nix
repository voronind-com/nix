{ secret, ... }@args:
let
  bash = import ./bash args;
in
{
  home-manager.enable = true;

  gpg = {
    enable = true;
    inherit (secret.crypto) publicKeys;
  };

  firefox = import ./firefox args;

  bash = {
    enable = true;
    initExtra = bash.bashrc;
  };
}

{ pkgs, ... }@args:
{
  sessionVariables = import ./variable.nix args;
}

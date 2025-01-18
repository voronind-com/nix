{ inputs, lib, pkgs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.wireless.enable = lib.mkForce false;

  # Override my settings to allow SSH logins using root password.
  services.openssh.settings = {
    PasswordAuthentication = lib.mkForce true;
    PermitRootLogin = lib.mkForce "yes";
  };

  # Needed by installer smh.
  environment.systemPackages = with pkgs; [
    ghc
  ];

  # Root user setup.
  home.nixos.enable = true;
  user.root = true;

  module = {
    keyd.enable = true;
    package.all = true;
    purpose = {
      live = true;
    };
  };
}

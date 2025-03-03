{
  config,
  inputs,
  lib,
  pkgs,
  secret,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Root user config.
  home.nixos.enable = true;
  user.root = true;
  users.users.root.hashedPassword = lib.mkForce secret.password.live;

  # Required for live iso.
  networking.wireless.enable = lib.mkForce false;
  boot.zfs.extraPools = lib.mkForce [ ];

  # Override my settings to allow SSH logins using root password.
  services.openssh.settings = {
    PasswordAuthentication = lib.mkForce true;
    PermitRootLogin = lib.mkForce "yes";
  };

  # Needed by installer smh.
  # TODO: Find out what it downloads.
  environment.systemPackages = with pkgs; [
    # tor-browser # NOTE: ???
    ghc
  ];

  module = {
    package.all = true;
    keyd.enable = true;
  };
}

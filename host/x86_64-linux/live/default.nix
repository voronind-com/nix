{ inputs, lib, ... }:
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

  # Root user setup.
  home.nixos.enable = true;
  user = {
    root = true;
    voronind = true;
  };

  module = {
    builder.client.enable = true;
    purpose.live = true;
  };
}

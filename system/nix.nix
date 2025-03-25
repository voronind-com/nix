{ inputs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecurePredicate = x: true; # HACK: Nix is fucking annoying sometimes.
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      keep-derivations = false;
      keep-outputs = false;
      min-free = 10 * 1000 * 1000 * 1000;
      trusted-users = [ "voronind" ];
      substituters = [ "https://nixos-cache-proxy.cofob.dev" ];
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # HACK: Remove channels from NIX_PATH.
  nixpkgs.flake = {
    setFlakeRegistry = false;
    setNixPath = false;
  };
  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
}

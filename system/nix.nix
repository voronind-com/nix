{ inputs, lib, ... }:
{
  nixpkgs.config = {
    # HACK: Nix is fucking annoying sometimes.
    allowUnfreePredicate = (pkg: true);
    allowInsecurePredicate = x: true;
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
      options = "--delete-older-than 7d";
    };
  };

  # Add source refs to etc.
  environment.etc =
    inputs
    |> lib.mapAttrsToList (n: v: n)
    |> lib.foldl' (acc: name: acc // { "source-${name}".source = inputs.${name}; }) { };

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

{ ... }:
{
  text = ''
    # Spawn shell with specified nix environment.
    # Uses flake.nix in current dir by default.
    # Usage: shell [NAME]
    function shell() {
      local target="''${1}"
      [[ "''${target}" = "" ]] && target="default"

      SHELL_NAME="''${target}" nix develop ".#''${target}"
    }

    # Spawn temporary nix-shell with specified packages.
    # Usage: tmpshell <PACKAGES>
    function tmpshell() {
      local IFS=$'\n'
      local input=("''${@}")
      local pkgs=()
      local tag="''${1}"

      if [[ "''${input}" = "" ]]; then
        help tmpshell
        return 2
      fi

      for pkg in ''${input[@]}; do
        pkgs+=("nixpkgs#''${pkg}")
      done

      SHELL_NAME="''${tag}" NIXPKGS_ALLOW_UNFREE=1 nix shell --impure ''${pkgs[@]}
    }

    # Run stuff directrly from Nixpks.
    # Usage: nixpkgs_run <REV> <PACKAGE> [COMMAND]
    function nixpkgs_run() {
      local rev="''${1}"
      local pkg="''${2}"
      local cmd="''${@:3}"

      if [[ "''${pkg}" = "" ]]; then
        help nixpkgs_run
        return 2
      fi

      [[ "''${cmd}" = "" ]] && cmd="''${pkg}"

      SHELL_NAME="''${pkg}" NIXPKGS_ALLOW_UNFREE=1 nix shell --impure github:NixOS/nixpkgs/''${rev}#''${pkg} -c ''${cmd}
    }
  '';
}

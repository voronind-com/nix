{ ... }:
{
  text = ''
    # Create/Attach to the box.
    # Uses name `main` by default.
    # Usage: da [BOX]
    function da() {
      local name="''${1}"

      [[ "''${name}" = "" ]] && name="main"
      # if [[ "''${name}" = "" ]]; then
      #   help da
      #   return 2
      # fi

      # --user 0 is required for rootless docker.
      distrobox enter -a '--user=0' "''${name}"
    }
  '';
}

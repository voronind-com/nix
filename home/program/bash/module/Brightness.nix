{ ... }:
{
  text = ''
    # Set display brightness to a minimum.
    function brmin() {
      light -S 0.01
    }

    # Set display brightness to a maximum.
    function brmax() {
      light -S 100
    }

    # Set display brightness in percent, 50% default.
    # Usage: brset [LEVEL]
    function brset() {
      local level=''${1}
      [[ "''${level}" = "" ]] && level=50

      light -S ''${level}
    }
  '';
}

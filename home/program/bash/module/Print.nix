{ ... }:
{
  text = ''
    # Printf shortcut.
    # Usage: print [TEXT]
    function print() {
      printf "%s" "''${*}"
    }
  '';
}

{ ... }:
{
  text = ''
    # Get terminal size.
    function tsize() {
      local width=$(tput cols)
      local height=$(tput lines)
      echo "''${width}x''${height}"
    }
  '';
}

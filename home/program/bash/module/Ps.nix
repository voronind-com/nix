{ ... }:
{
  text = ''
    # Find process and filter.
    # Usage: fps [PROCESS]
    function fps() {
      local process="''${1}"

      if [[ "''${process}" = "" ]]; then
        ps aux
      else
        ps aux | sed -n -e "1p" -e "/''${process}/Ip" | sed -e "/sed -n -e 1p -e/d"
      fi
    }
  '';
}

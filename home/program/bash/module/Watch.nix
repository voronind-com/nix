{ ... }:
{
  text = ''
    # Watch command output with 2 seconds interval.
    # Usage: w <COMMAND>
    function w() {
      if [[ "''${*}" = "" ]]; then
        help w
        return 2
      fi

      watch -n 2 "''${@}"
    }

    # Watch command output with minimal interval.
    # Usage: ww <COMMAND>
    function ww() {
      if [[ "''${*}" = "" ]]; then
        help ww
        return 2
      fi

      watch -n 0 "''${@}"
    }

    # Autocomplete.
    complete -F _autocomplete_nested w ww
  '';
}

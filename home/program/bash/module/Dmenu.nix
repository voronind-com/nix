{ ... }:
{
  text = ''
    # Wrapped dmenu_path to include my functions.
    function _dmenu_path_wrapped() {
      c=0
      while [ ''${c} -lt 1000 ]; do
        echo
        ((c++))
      done

      find_function | grep -v ^_
      dmenu_path
    }
  '';
}

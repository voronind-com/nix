{ ... }:
{
  text = ''
    # Run something recursively over all directories.
    # Usage: recursive <COMMAND>
    function recursive() {
      if [[ "''${*}" = "" ]]; then
        help recursive
        return 2
      fi

      local IFS=$'\n'
      local current="''${PWD}"
      local dirs=$(find -type d)
      local total=$(find -type d | wc -l) # TODO: don't call find twice. won't work with "echo ''${dirs}".
      local count=0
      local failed=0

      for dir in ''${dirs}; do
        # increment counter.
        ((count++))

        # cd into the next dir.
        cd "''${current}" || failed=''${?}
        cd "''${dir}" || failed=''${?}

        # echo status.
        echo -e "''${color_bblue}[''${count}/''${total}] ''${dir}''${color_default}"

        # run command.
    ''${*} || failed=''${?}

        # Add newline if not the last one.
        [[ "''${count}" = "''${total}" ]] || echo
      done

      # return back on complete.
      cd "''${current}" || failed=''${?}

      return ''${failed}
    }

    # Run something recursively over directories of 1 depth (excluding current dir).
    # Usage: recursive1 <COMMAND>
    function recursive1() {
      if [[ "''${*}" = "" ]]; then
        help recursive1
        return 2
      fi

      local IFS=$'\n'
      local current="''${PWD}"
      local dirs=$(find -mindepth 1 -maxdepth 1 -type d)
      local total=$(find -mindepth 1 -maxdepth 1 -type d | wc -l) # TODO: don't call find twice. won't work with "echo ''${dirs}".
      local count=0
      local failed=0

      for dir in ''${dirs}; do
        # increment counter.
        ((count++))

        # cd into the next dir.
        cd "''${current}"
        cd "''${dir}"

        # echo status.
        echo -e "''${color_bblue}[''${count}/''${total}] ''${dir}''${color_default}"

        # run command.
    ''${*} || failed=''${?}

        # Add newline if not the last one.
        [[ "''${count}" = "''${total}" ]] || echo
      done

      # return back on complete.
      cd "''${current}"

      return ''${failed}
    }

    # autocomplete.
    complete -F _autocomplete_nested recursive recursive1
  '';
}

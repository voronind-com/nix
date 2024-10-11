{ ... }:
{
  text = ''
    # Group files by extension.
    # Usage: group_ext [FILES]
    function group_ext() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_file))

      process() {
        local ext=''${target##*.}
        [[ -d "''${target}" ]] && { _iterate_skip "Is a directory."; return 0; }
        [[ "''${ext}" = "''${target}" ]] && { _iterate_skip "No extension."; return 0; }

        mkdir ''${ext} 2> /dev/null

        mv -- ''${target} ./''${ext}/''${target}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Group files and dirs by year.
    # Usage: group_year [FILES]
    function group_year() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(ls))

      process() {
        local year=$(stat --format=%y ''${target})
        year=''${year%%-*}

        mkdir ''${year} 2> /dev/null

        mv -- ''${target} ./''${year}/''${target}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Copy files from current year to the named dir.
    # Usage: group_year_copy <YEAR> [FILES]
    function group_year_copy() {
      local IFS=$'\n'
      local selected_year="''${1}"
      local targets=(''${@:2})

      if [[ "''${selected_year}" = "" ]]; then
        help group_year_copy
        return 2
      fi

      # All files by default.
      [[ "''${targets}" = "" ]] && targets=($(ls))

      mkdir ''${selected_year} 2> /dev/null

      process() {
        local year=$(stat --format=%y ''${target})
        year=''${year%%-*}

        if [[ "''${year}" = "''${selected_year}" ]]; then
          rcp -- ''${target} ./''${selected_year}/
        else
          _iterate_skip "Skip: ''${year}"
        fi
      }

      _iterate_targets process ''${targets[@]}
    }
  '';
}

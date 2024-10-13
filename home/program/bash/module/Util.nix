{ ... }:
{
  text = ''
    # Get the number of avaialble cores (threads).
    function _core_count() {
      cat /proc/cpuinfo | grep ^processor | wc -l
    }

    # Get the number of available memory (in mebibytes).
    function _mem_free() {
      free -m | sed -n -e '2p' | awk '{print $7}'
    }

    # Function-wrapper to iterate with specified function with provided files.
    # By default Iterates on all non-hidden files and directories.
    # List of variables available to FUNCTION: target - current file, count - current item index, total - sum of targets, failed - count of previously failed items, skipped - count of skipped files, status - status line (not recommended to use).
    # Usage: _iterate_targets <FUNCTION> [FILES]
    function _iterate_targets() {
      local IFS=$'\n'
      local foo="''${1}"
      local targets=("''${@:2}")
      local total=''${#targets[@]}
      local count=0
      local failed=0
      local skipped=0
      local code=0

      # set dafult value to target all supported archives.
      if [[ "''${targets}" = "" ]]; then
        _error "No targets provided."
        return 1
      fi

      # iterate each target.
      for target in "''${targets[@]}"; do
        # increment counter.
        ((count++))

        # status info.
        local status="[''${count}/''${total}] ''${target}"
        _info "''${status}"

        # Call function.
        ''${foo} "''${target}"

        # Show error.
        if [[ ''${?} != 0 ]]; then
          ((failed++))
          _error "''${status}: Failed."
        fi

        # Add newline if not the last one.
        [[ "''${count}" = "''${total}" ]] || _info
      done

      # Show skipped.
      if [[ ''${skipped} != 0 ]]; then
        _warn
        _warn "''${color_byellow}Skipped: ''${skipped}.''${color_default}"
      fi

      # Show error.
      if [[ ''${failed} != 0 ]]; then
        [[ "''${skipped}" = 0 ]] && _error
        _error "''${color_bred}Failed: ''${failed}.''${color_default}"
        false
      fi
    }

    # Skip current iteration.
    # Usage: _iterate_skip [MESSAGE]
    function _iterate_skip() {
      ((skipped++))

      [[ "''${*}" != "" ]] && _warn "''${color_byellow}''${*}''${color_default}"
    }

    # Report an error.
    # Always returns code 1.
    # Usage: _error <MESSAGE>
    function _error() {
      >&2 echo -e "''${color_bred}''${*}''${color_default}"
      return 1
    }

    # Report a warning.
    # Usage: _warn <MESSAGE>
    function _warn() {
      >&2 echo -e "''${color_byellow}''${*}''${color_default}"
    }

    # Report a debug.
    # Usage: _debug <MESSAGE>
    function _debug() {
      >&2 echo -e "''${color_bwhite}''${*}''${color_default}"
    }

    # Report an info.
    # Usage: _info <MESSAGE>
    function _info() {
      >&2 echo -e "''${color_bwhite}''${*}''${color_default}"
    }

    # Check if array contains an element (strict).
    # Usage: _contains <ELEMENT> <ARRAY>
    function _contains() {
      local IFS=$'\n'
      local target="''${1}"
      local array="''${@:2}"

      if [[ "''${target}" = "" ]] || [[ "''${array}" = "" ]]; then
        help _contains
        return 2
      fi

      for item in ''${array[@]}; do
        [[ "''${item}" = "''${target}" ]] && return 0
      done

      return 1
    }

    # Find an index of an element in array.
    # Usage: _index_of <ELEMENT> <ARRAY>
    function _index_of() {
      local element="''${1}"
      local array="''${@:2}"
      local index=0

      for item in ''${array[@]}; do
        [[ "''${item}" = "''${element}" ]] && break
        ((index++))
      done

      echo "''${index}"
    }

    # Check if inside Tmux.
    function _is_tmux() {
      [[ "''${TERM_PROGRAM}" = "tmux" ]]
    }

    # Check if root.
    function _is_root() {
      [[ "''${UID}" = 0 ]]
    }

    # Ring a bell.
    function _bell() {
      echo -e '\a'
    }

    # Get users.
    function _get_users() {
      local users=("voronind" "dasha")
      echo ''${users[@]}
    }
  '';
}

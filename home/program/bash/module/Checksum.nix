{ ... }:
{
  text = ''
    # Save file checksums.
    # For file with a name `file` it will create a new file called `.file.sha1` with hash in it.
    # All files by default.
    # Usage: checksum_create [FILES]
    function checksum_create() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_file))

      process() {
        local hashfile=".''${target#./}.sha1"

        # Skip if hash exists.
        [[ -f "''${hashfile}" ]] && return 0

        # Calculate hash.
        pv ''${target} | sha1sum > ''${hashfile}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Check stored values against actual files.
    # All files by default.
    # Usage: checksum_check [FILES]
    function checksum_check() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_file))

      process() {
        local hashfile=".''${target#./}.sha1"

        # Skip if hash doesn't exist.
        [[ -f "''${hashfile}" ]] || { _iterate_skip "No hash found."; return 0; }

        # Calculate hash.
        local stored=$(cat "''${hashfile}" | cut -d\  -f1)
        local actual=$(pv "''${target}" | sha1sum | cut -d\  -f1)

        if [[ "''${stored}" != "''${actual}" ]]; then
          _error "Failed."
          return 1
        fi
      }

      _iterate_targets process ''${targets[@]}
    }

    # Calculate hashes for all files recursively and store in a file called `checksum.sha1`.
    function checksum() {
      find -type f | parallel -j $(_core_count) -- sha1sum {} >> checksum.sha1
    }

    # Create checksum for a file.
    # Usage: _checksum_create <FILE>
    function _checksum_create() {
      local path="''${1%/*}"
      local name="''${1##*/}"
      sha1sum "''${path}/''${name}" > "''${path}/.''${name}.sha1"
    }

    # Check checksum for a file.
    # Usage: _checksum_check <FILE>
    function _checksum_check() {
      local file="''${1##*\ \ }"
      local stored="''${1%%\ \ *}"

      # Skip if no file.
      [[ -f "''${file}" ]] || return 0

      # Check file hash.
      local actual=$(sha1sum "''${file}")
      actual="''${actual%%\ \ *}"

      # Compare values.
      if [[ "''${stored}" != "''${actual}" ]]; then
        _error "''${file}: Failed."
        return 1
      fi

      return 0
    }
  '';
}

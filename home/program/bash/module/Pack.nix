{ ... }:
{
  text = ''
    export _unpack_supported=".tar$|.tgz$|.txz$|.tar.gz$|.tar.xz$|.zip$|.iso$|.rar$"

    # Pack files into desired format.
    # All files and directories by default.
    # Usage: pack <TARGET.ext> [FILES]
    function pack() {
      local IFS=$'\n'
      local output="''${1}"
      local targets=("''${@:2}")
      local format="''${output##*.}"
      local name="''${output%.*}"

      # report no output.
      if [[ "''${output}" = "" ]]; then
        help pack
        return 2
      fi

      # report no format.
      if [[ "''${format}" = "" ]]; then
        _error "Could not determine output format."
        help pack
        return 2
      fi

      # All targets by default.
      [[ "''${targets}" = "" ]] && targets=(*)

      case "''${format}" in
        "tgz")
          _pack_tgz "''${output}" "''${targets[@]}"
          ;;
        "txz")
          _pack_txz "''${output}" "''${targets[@]}"
          ;;
        "tar")
          _pack_tar "''${output}" "''${targets[@]}"
          ;;
        "zip")
          _pack_zip "''${output}" "''${targets[@]}"
          ;;
        "gz")
          _pack_gz "''${output}" "''${targets[@]}"
          ;;
        "xz")
          _pack_xz "''${output}" "''${targets[@]}"
          ;;
        "iso")
          _pack_iso "''${output}" "''${targets[@]}"
          ;;
        *)
          _error "''${target}: Format not supported."
          return 2
          ;;
      esac
    }

    # Attempt to unpack.
    # All supported formats by default.
    # Usage: unpack [FILES]
    function unpack() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_files | grep -E ''${_unpack_supported}))

      process() {
        # Use full path to file.
        target=''$(realpath "''${target}")

        # Check for archive.
        if $(_is_archive "''${target}"); then
          unarchive "''${target}"
          return 0
        fi

        # Unpack file type.
        local type="''${target##*.}"

        [[ "''${target}" =~ .tar.gz$ ]] && type="tar.gz"
        [[ "''${target}" =~ .tar.xz$ ]] && type="tar.xz"

        # Make a dir for files.
        local dir="''${target%.$type}"; dir="''${dir##*/}"
        mkdir "''${dir}" > /dev/null
        pushd "''${dir}" > /dev/null

        # Unpack content.
        case "''${type,,}" in
          "zip")
            _unpack_zip "''${target}"
            ;;
          "7z")
            _unpack_7z "''${target}"
            ;;
          "tgz"|"tar.gz")
            _unpack_tgz "''${target}"
            ;;
          "txz"|"tar.xz")
            _unpack_txz "''${target}"
            ;;
          "tar")
            _unpack_tar "''${target}"
            ;;
          "iso")
            _unpack_iso "''${target}"
            ;;
          "rar")
            _unpack_rar "''${target}"
            ;;
          "xz")
            _unpack_xz "''${target}"
            ;;
          "gz")
            _unpack_gz "''${target}"
            ;;
          *)
            _error "''${target}: Format not supported."
            return 2
            ;;
        esac

        # Cd back.
        popd > /dev/null
      }

      _iterate_targets process ''${targets[@]}
    }

    function _pack_zip() {
      zip -9 -r "''${@}"
    }

    function _pack_tgz() {
      tar -c "''${@:2}" | pv -s $(/usr/bin/env du -csb "''${@:2}" | sed -n -e '$p' | awk '{print $1}') | gzip -1 > "''${1}"
    }

    function _pack_txz() {
      tar -c "''${@:2}" | pv -s $(/usr/bin/env du -csb "''${@:2}" | sed -n -e '$p' | awk '{print $1}') | xz -9e > "''${1}"
    }

    function _pack_tar() {
      tar -c "''${@:2}" | pv -s $(/usr/bin/env du -csb "''${@:2}" | sed -n -e '$p' | awk '{print $1}') > "''${1}"
    }

    function _pack_gz() {
      pv "''${2}" | gzip -1 > "''${1}"
    }

    function _pack_xz() {
      pv "''${2}" | xz -9e > "''${1}"
    }

    function _pack_iso() {
      local input=("''${@:2}")
      local output="''${1}"
      local args=()

      for arg in ''${input[@]}; do
        [[ -d "''${arg}" ]] || {
          _error "''${arg} is not a directory."
          return 1
        };

        args+=("''${arg}=''${arg}")
      done

      genisoimage -J -r -pad -o "''${output}" -graft-points "''${args[@]}"
    }

    function _unpack_zip() {
      unzip "''${1}"
    }

    function _unpack_7z() {
      7za x "''${1}"
    }

    function _unpack_tgz() {
      pv "''${1}" | gzip -d | tar -xf -
    }

    function _unpack_txz() {
      pv "''${1}" | xz -d | tar -xf -
    }

    function _unpack_tar() {
      pv "''${1}" | tar -xf -
    }

    function _unpack_iso() {
      7za x "''${1}"
    }

    function _unpack_rar() {
      unrar x "''${1}"
    }

    function _unpack_gz() {
      pv "''${1}" | gzip -d > "''${1%.gz}"
    }

    function _unpack_xz() {
      pv "''${1}" | xz -d > "''${1%.xz}"
    }
  '';
}

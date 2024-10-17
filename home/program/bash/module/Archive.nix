{ ... }:
{
  text = ''
    export _archive_pattern="_[0-9]{12}-[[:alnum:]]{40}"
    export _archive_pattern_compressed="_[0-9]{12}-[[:alnum:]]{40}\.t(ar|gz|xz)$"
    export _archive_pattern_fast="_[0-9]{12}-[[:alnum:]]{40}\.tar$"

    # Archive using multiple threads. Uses 75% of free RAM.
    # All directories by default.
    # Supports .archiveignore exclude file.
    # Usage: archive [DIRS]
    function archive() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_dir))

      process() {
        # Skip if already an archive.
        _is_archive "''${target}" && {
          _iterate_skip "Already an archive."
          return 0
        };

        # Cut full paths.
        [[ "''${target##*/}" = "" ]] || target="''${target##*/}"

        local date=$(_archive_date)

        # Parse name.
        local name=$(parse_pascal ''${target})

        # Exclude support.
        local exclude=""
        [[ -f ".archiveignore" ]] && exclude="--exclude-from=.archiveignore"
        [[ -f "''${target}/.archiveignore" ]] && exclude="--exclude-from=''${target}/.archiveignore"

        # Create archive.
        local hash=$(tar ''${exclude} -c ''${target} | pv -s $(/usr/bin/env du -sb ''${target} | awk '{print $1}') | xz -9e --threads=0 --memlimit=$(_archive_memlimit) | tee ''${name}.txz | sha1sum | cut -d\  -f1)

        # Append hash to target name.
        local new_name="''${name}_''${date}-''${hash}.txz"
        mv -- ''${name}.txz ''${new_name} && echo ''${new_name}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Creates a simple archive.
    # If it is a file, it just reformats file name to match archive name.
    # For dirs, it first creates a tar archive.
    # All files by default.
    # Usage: archive_fast [DIRS]
    function archive_fast() {
      local IFS=$'\n'
      local targets=("''${@}")
      [[ "''${targets}" = "" ]] && targets=($(_ls_file))

      process() {
        # Skip if already an archive.
        _is_archive "''${target}" && {
          _iterate_skip "Already an archive."
          return 0
        };

        # Cut full paths.
        [[ "''${target##*/}" = "" ]] || target="''${target##*/}"

        # Start timestamp.
        local date=$(_archive_date)

        # Exclude support.
        local exclude
        [[ -f ".archiveignore" ]] && exclude="--exclude-from=.archiveignore"
        [[ -f "''${target}/.archiveignore" ]] && exclude="--exclude-from=''${target}/.archiveignore"

        local name
        local extension

        if [[ -d "''${target}" ]]; then
          name=$(parse_pascal "''${target}")

          # Create archive.
          local hash=$(tar ''${exclude} -c "''${target}" | pv -s $(/usr/bin/env du -sb "''${target}" | awk '{print $1}') | tee "''${name}".tar | sha1sum | cut -d\  -f1)

          # Append hash to target name.
          local new_name="''${name}_''${date}-''${hash}.tar"
          mv -- "''${name}".tar ''${new_name} && echo ''${new_name}
        else
          name=$(parse_pascal "''${target%.*}")
          extension=".''${target##*.}"

          # Check if extension matches name, then drop it.
          [[ "''${extension}" = ".''${target%.*}" ]] && extension=""

          local hash=$(pv "''${target}" | sha1sum | cut -d\  -f1)
          local new_name="''${name}_''${date}-''${hash}''${extension}"
          mv -- "''${target}" "''${new_name}" && echo ''${new_name}
        fi
      }

      _iterate_targets process ''${targets[@]}
    }

    # Check archives integrity.
    # Checks all archives by default.
    # Usage: archive_check [FILES]
    function archive_check() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_archive))

      process() {
        _archive_check "''${target}"
      }

      _iterate_targets process ''${targets[@]}
    }

    # Delete old versions of an archive.
    # All archives with 1 version by default.
    # Usage: archive_prune [NAME] [VERSIONS]
    function archive_prune() {
      local IFS=$'\n'
      local targets=(''${1})
      local versions=''${2}

      [[ "''${targets}" = "" ]] && targets=($(_archive_names))
      [[ "''${versions}" = "" ]] && versions=1

      if [[ ''${#} -gt 2 ]]; then
        help archive_prune
        return 2
      fi

      process() {
        local prune=($(ls | grep -E "^''${target}''${_archive_pattern}" | sort -r | sed -e "1,''${versions}d"))

        for archive in ''${prune[@]}; do
          rm -- "''${archive}" && echo "''${archive}"
        done
      }

      _iterate_targets process ''${targets[@]}
    }

    # Delete specified or all archive files.
    # Usage: archive_rm [FILES]
    function archive_rm() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=($(_ls_archive))

      process() {
        rm -- "''${target}" && echo "''${target}"
      }

      _iterate_targets process ''${targets[@]}
    }

    # Recompress previously created archive_fast with better compression.
    # Usage: archive_compress [FILES]
    function archive_compress() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=$(_ls_archive_fast)

      process() {
        local data=($(_archive_parse "''${target}"))
        local tmp="''${data[0]}.txz"

        # Check that old format.
        if [[ "''${data[3]}" != "tar" ]]; then
          _iterate_skip "Not in .tar format!"
          return 0
        fi

        # Check integrity.
        _archive_check "''${target}" || return 1

        # Recompress.
        local hash=$(pv "''${target}" | xz -9e --threads=0 --memlimit=$(_archive_memlimit) | tee "''${tmp}" | sha1sum | cut -d\  -f1)

        # Rename.
        local new_name="''${data[0]}_''${data[1]}-''${hash}.txz"
        mv -- ''${tmp} ''${new_name} && rm ''${target} && echo ''${new_name}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Rename archives.
    # If no name specified, it simplifies archive's name.
    # If no archives specified, apply to all archives.
    # Usage: archive_name [ARCHIVE] [NAME]
    function archive_name() {
      local IFS=$'\n'
      local targets="''${1}"
      local name="''${2}"
      [[ "''${targets}" = "" ]] && targets=($(_ls_archive))

      process() {
        # Simplify name by default.
        if [[ "''${name}" = "" || ''${count} -gt 1 ]]; then
          name="''${target%_*}"
          name="$(parse_pascal ''${name})"
        fi

        # Remove old name.
        local data="''${target##*_}"
        local new_name="''${name}_''${data}"

        # Check for the same name.
        [[ "''${target}" = "''${new_name}" ]] && return 0

        # Check for existing target.
        if [[ -f "''${new_name}" ]]; then
          _error "''${new_name}: Already exists!"
          return 1
        fi

        # Rename.
        mv -- ''${target} ''${new_name} && echo ''${new_name}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Extract previously created archive with checksum validation.
    # Supports unarchiving exact paths from the remote machines (rsync syntax).
    # Usage: unarchive [HOST:FILES]
    function unarchive() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=$(_ls_archive_compressed)

      process() {
        # Validate.
        # _archive_check "''${target}" || return 1
        if ! _is_compressed_archive "''${target}"; then
          _iterate_skip "Not a compressed archive."
          return 0
        fi

        # Remote archives.
        local remote
        local file="''${target}"

        if [[ "''${target//\\:/}" == *:* ]]; then
          local host="''${target%%:*}"
          file="''${target#*:}"
          remote=(trysudo ssh ''${host})
        fi

        # Extract.
        case "''${file##*.}" in
          "txz")
            ''${remote[@]} pv -f ''${file} | xz -d | tar -xf -
            ;;
          "tar")
            ''${remote[@]} pv -f ''${file} | tar -xf -
            ;;
          "tgz")
            ''${remote[@]} pv -f ''${file} | gzip -d | tar -xf -
            ;;
        esac
      }

      _iterate_targets process ''${targets[@]}
    }

    # Change archive's filesystem time to match creation date.
    # Usage: archive_touch [FILES]
    function archive_touch() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=$(_ls_archive)

      process() {
        local data=($(_archive_parse "''${target}"))
        local date=''${data[1]}
        touch -t ''${date} -- ''${target}
      }

      _iterate_targets process ''${targets[@]}
    }

    # Parse archive file name to get: name, date, hash and format.
    # Usage: _archive_parse <FILENAME>
    function _archive_parse() {
      local input="''${1}"
      local name="''${input%_*}"
      local format="''${input##*.}"
      local data="''${input##*_}"; data="''${data%.*}"
      local date="''${data%%-*}"
      local hash="''${data##*-}"

      # No extension if no dots.
      [[ "''${input}" = *\.* ]] || format=""

      echo "''${name}"
      echo "''${date}"
      echo "''${hash}"
      echo "''${format}"
    }

    # Autocomplete for archive_name function.
    # First arg is the archives list, second one is selected archive's current name.
    function _comp_archive_name() {
      local IFS=$'\n'
      COMPREPLY=()

      local cur="''${COMP_WORDS[COMP_CWORD]}"
      local prev="''${COMP_WORDS[COMP_CWORD-1]}"
      local command="''${COMP_WORDS[0]}"

      if [[ "''${prev}" = "''${command}" ]]; then
        COMPREPLY=( $(compgen -W "$(ls | grep -E ''${_archive_pattern})" -- ''${cur}) )
        return 0
      else
        local data=($(_archive_parse ''${prev}))
        local name="''${data[0]}"
        COMPREPLY=( $(compgen -W "''${name}" -- ''${cur}) )
        return 0
      fi
    }

    # Autocomplete with archives in current dir.
    function _comp_archive_grep() {
      _autocomplete_grep ''${_archive_pattern}
    }

    # Autocomplete with fast archives in current dir.
    function _comp_archive_grep_fast() {
      _autocomplete_grep ''${_archive_pattern_fast}
    }

    # Get date for a new archive.
    function _archive_date() {
      date +%Y%m%d%H%M
    }

    # Get names of all archives.
    function _archive_names() {
      local IFS=$'\n'
      local archives=($(_ls_archive))
      local names=()

      for archive in ''${archives[@]}; do
        local data=($(_archive_parse ''${archive}))
        names+=(''${data[0]})
      done

      # Remove copies.
      names=($(printf '%s\n' "''${names[@]}" | sort -u))

      printf '%s\n' "''${names[@]}"
    }

    # Autocomplete with names of all archives.
    function _comp_archive_names() {
      _autocomplete_first $(_archive_names)
    }

    # Check if file is an archive.
    function _is_archive() {
      local target="''${*}"
      local out=$(echo "''${target##*/}" | grep -E ''${_archive_pattern})

      [[ "''${out}" != "" ]]
    }

    # Check if file is a compressed archive.
    function _is_compressed_archive() {
      local out=$(echo "''${*}" | grep -E ''${_archive_pattern_compressed})

      [[ "''${out}" != "" ]]
    }

    # List all archives.
    function _ls_archive() {
      ls | grep -E ''${_archive_pattern}
    }

    # List fast archives.
    function _ls_archive_fast() {
      ls | grep -E ''${_archive_pattern_fast}
    }

    # List fast archives.
    function _ls_archive_compressed() {
      ls | grep -E ''${_archive_pattern_compressed}
    }

    # Filter input for archives only.
    function _filter_archive() {
      grep -E ''${_archive_pattern}
    }

    function _archive_memlimit() {
      local mem_free=$(_mem_free)
      local mem_limit=$((mem_free*3/4))

      echo "''${mem_limit}MiB"
    }

    function _archive_check() {
      # Extract hash from name.
      local data=($(_archive_parse ''${target}))
      local saved=''${data[2]}

      # Calculate actual hash.
      local actual=$(pv ''${target} | sha1sum | cut -d\  -f1)

      # Compare hashes.
      [[ "''${actual}" = "''${saved}" ]] || _error "Archive check failed."
    }

    # complete -o filenames -F _comp_archive_grep        archive_check unarchive archive_rm archive_touch
    # complete -o filenames -F _comp_archive_grep_fast   archive_xz
    complete -o filenames -F _comp_archive_name        archive_name
    complete -o filenames -F _comp_archive_names       archive_prune
  '';
}

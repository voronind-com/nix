{ ... }:
{
  text = ''
    # Bash autocomplete.
    # There are also options like -o nospace. see man for more info.
    # Usage: _foo() { _autocomplete "{foo,bar}" } ; complete -F _foo foo
    function _autocomplete() {
      local IFS=$'\n'
      local commands="''${*}"

      COMPREPLY=()

      local cur="''${COMP_WORDS[COMP_CWORD]}"
      local prev="''${COMP_WORDS[COMP_CWORD-1]}"
      local command="''${COMP_WORDS[0]}"

      COMPREPLY=( $(compgen -W "''${commands}" -- ''${cur}) )
      return 0
    }

    # Autocomplete only first argument.
    function _autocomplete_first() {
      local IFS=$'\n'
      local commands="''${*}"

      COMPREPLY=()

      local cur="''${COMP_WORDS[COMP_CWORD]}"
      local prev="''${COMP_WORDS[COMP_CWORD-1]}"
      local command="''${COMP_WORDS[0]}"

      if [[ "''${prev}" = "''${command}" ]]; then
        COMPREPLY=( $(compgen -W "''${commands}" -- ''${cur}) )
        return 0
      fi
    }

    # Autocomplete only first argument and the rest with files.
    function _autocomplete_first_ls() {
      local IFS=$'\n'
      local commands="''${*}"

      COMPREPLY=()

      local cur="''${COMP_WORDS[COMP_CWORD]}"
      local prev="''${COMP_WORDS[COMP_CWORD-1]}"
      local command="''${COMP_WORDS[0]}"

      if [[ "''${prev}" = "''${command}" ]]; then
        COMPREPLY=( $(compgen -W "''${commands}" -- ''${cur}) )
        return 0
      else
        COMPREPLY=( $(compgen -W "$(ls)" -- ''${cur}) )
        return 0
      fi
    }

    # Autocomplete by grepping file names.
    function _autocomplete_grep() {
      local IFS=$'\n'
      COMPREPLY=()

      local pattern="''${1}"
      local cur="''${COMP_WORDS[COMP_CWORD]}"
      local prev="''${COMP_WORDS[COMP_CWORD-1]}"
      local command="''${COMP_WORDS[0]}"

      COMPREPLY=( $(compgen -W "$(ls | grep -E ''${pattern})" -- ''${cur}) )
      return 0
    }

    # Autocomplete nested program.
    function _autocomplete_nested() {
      # local IFS=$'\n'
      local cur prev words cword split i
      _init_completion -s || return

      for ((i = 1; i <= cword; i++)); do
        if [[ ''${words[i]} != -* ]]; then
          local PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
          local root_command=''${words[i]}
          _command_offset ''${i}
          return
        fi
      done
    }
  '';
}

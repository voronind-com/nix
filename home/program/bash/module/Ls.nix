{ ... }: {
	text = ''
		# Unset possible system-defined aliases.
		unalias l ll lll llll la lla &> /dev/null
		unset l ll lll llll la lla &> /dev/null

		# List files in dirs.
		# Current dir by default.
		# Usage: l [DIRS]
		function l() {
			# ls -lhv --si --group-directories-first --color=auto -- "$@"
			ccd "$@"
		}

		# List last modified files first.
		# Current dir by default.
		# Usage: ll [DIRS]
		function ll() {
			ls -lhv --si --group-directories-first --color=auto -- "$@"
			# ls -lhvtr --si --color=auto -- "$@"
		}

		# List files in tree structure.
		# Current dir by default.
		# Depth can be omitted by passing `-` (dash).
		# Usage: lll [DEPTH] [DIRS]
		function lll() {
			local IFS=$'\n'
			local depth="''${1}"
			local target=("''${@:2}")

			[[ "''${target}" = "" ]] && target="."
			[[ "''${depth}" = "" ]] && depth=666
			[[ "''${depth}" = "-" ]] && depth=666

			tree -a -L "''${depth}" -- "''${target[@]}"
		}

		# List files recursively.
		# Current dir by default.
		# Usage: llll [DIRS]
		function llll() {
			ls -RlAhv --si --group-directories-first --color=auto -- "$@"
		}

		# List all files in dirs, incl. hidden files.
		# Current dir by default.
		# Usage: la [DIRS]
		function la() {
			ls -lAh --si --group-directories-first --color=auto -- "$@"
		}

		# List all files in dirs, incl. hidden files, sorted by mtime.
		# Current dir by default.
		# Usage: lla [DIRS]
		function lla() {
			ls -lAhtr --si --color=auto -- "$@"
		}

		# List only files.
		function _ls_file() {
			ls --classify | grep -v \/$
		}

		# List only dirs.
		function _ls_dir() {
			ls --classify | grep \/$ | sed -e "s/\/$//"
		}
	'';
}

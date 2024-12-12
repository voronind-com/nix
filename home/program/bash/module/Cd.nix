{ ... }: {
	text = ''
		# CD (back to) directory.
		# Goes to the exact-match dir first. If no exact match found, it finds first directory that contains the input (case-insensitive).
		# Usage: cdd <DIR>
		function cdd() {
			local target="''${1}"

			if [[ "''${target}" = "" ]]; then
				help cdd
				return 2
			fi

			local array=($(_cdd_directories))
			local result

			# Check for exact match ELSE look for containing.
			if _contains ''${target} ''${array[@]}; then
				local current="''${PWD%/*}"
				result="''${current%\/$target\/*}/''${target}"
			else
				# Make search case-insensitive.
				shopt -s nocasematch

				# Find dir name that contains input.
				local found=1
				for (( idx=''${#array[@]}-1 ; idx>=0 ; idx-- )); do
					dir="''${array[idx]}"
					[[ "''${dir}" =~ "''${target}" ]] && found=0
					[[ ''${found} = 0 ]] && result="/''${dir}''${result}"
				done

				# Clean-up???
				shopt -u nocasematch
			fi

			# Go there!
			if [[ "''${result}" != "" ]]; then
				echo "''${result}"
				cd "''${result}"
			else
				return 1
			fi
		}

		# CLI cd. Opens CLI file manager.
		function ccd() {
			local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
			yazi "$@" --cwd-file="$tmp"
			if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
				cd -- "$cwd"
			fi
			rm -f -- "$tmp"
		}

		# Get list of all parent dirs.
		function _cdd_directories() {
			local array
			IFS='/' read -r -a array <<< "''${PWD}"
			array=("''${array[@]:1}")
			unset array[-1]
			printf "%s\n" "''${array[@]}"
		}

		function _comp_cdd() {
			local IFS=$'\n'
			local dirs=($(_cdd_directories))
			_autocomplete ''${dirs[@]}
		}

		complete -o nosort -o filenames -F _comp_cdd cdd
	'';
}

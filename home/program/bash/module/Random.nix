{ ... }: {
	text = ''
		# Generate random string.
		# Usage: random <LENGTH>
		function random() {
			local length="''${1}"
			if [[ "''${length}" = "" ]]; then
				help random
				return 2
			fi
			head /dev/urandom | tr -dc A-Za-z0-9 | head -c''${length}
		}

		# Picks a random file or directory.
		function random_file() {
			local IFS=$'\n'
			local dirs=($(ls))
			local total=''${#dirs[@]}
			((total--))
			local index=$(shuf -i 0-''${total} -n 1)

			printf "%s" ''${dirs[$index]}
		}
	'';
}

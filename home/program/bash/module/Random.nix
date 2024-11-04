{ ... }: {
	text = ''
		# Picks a random file or directory.
		function random_file() {
			local IFS=$'\n'
			local dirs=($(ls))
			local total=''${#dirs[@]}
			((total--))
			local index=$(shuf -i 0-''${total} -n 1)

			echo ''${dirs[$index]}
		}
	'';
}

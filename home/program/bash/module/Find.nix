{ ... }: {
	text = ''
		# Find all file extensions.
		function find_ext() {
			local types=($(find -type f | sed -e "s/.*\///" -e "s/^\.//" -e "/\./!d" -e "s/.*\.//"))
			echo "''${types[@]}" | tr ' ' '\n' | sort -u
		}
	'';
}

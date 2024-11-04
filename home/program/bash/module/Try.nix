{ ... }: {
	text = ''
		# Retry command every 2 sec until it completes successfully.
		# Usage: try <COMMAND>
		function try() {
			if [[ "''${*}" = "" ]]; then
				help try
				return 2
			fi

			local result=-1

			while [ "$result" != 0 ]; do
		''${*}
				result=$?
				if [ "$result" != 0 ]; then
					sleep 2
				fi
			done
		}

		# autocomplete.
		complete -F _autocomplete_nested try
	'';
}

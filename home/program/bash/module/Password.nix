{ ... }: {
	text = ''
		# Setup the pw manager.
		function pwsetup() {
			bw config server 'https://pass.voronind.com'
			bw login
		}

		# Unlock the vault for current shell.
		function pwunlock() {
			if [ -z ''${BW_SESSION} ]; then
				export BW_SESSION=$(bw unlock --raw)
			fi
		}

		# Lock the vault for current shell.
		function pwlock() {
			bw lock
			unset BW_SESSION
		}

		# List all password entries.
		function pwlist() {
			bw list items | jq -r '.[] | .name'
		}

		# Get entry data.
		# Usage: pwget <NAME>
		function pwget() {
			local IFS=$'\n'
			local entry="''${*}"

			if [[ "''${entry}" = "" ]]; then
				help pwget
				return 2
			fi

			local ids=($(_pwids "''${entry}"))

			for id in "''${ids[@]}"; do
				local result=($(bw get item "''${id}" | jq -r '(.name), (.login | .username, .password, .uris[].uri)'))
				local name="''${result[0]}"
				local login="''${result[1]}"
				local password="''${result[2]}"
				local urls=(''${result[@]:3})

				printf "\nName: %s\n" "''${name}"
				printf "Login: %s\n" "''${login}"
				printf "Password: %s\n" "''${password}"
				printf "Url: %s\n" "''${urls[@]}"
			done
		}

		function _pwids() {
			bw list items | jq -r '.[] | select(.name | match(".*'$*'.*")) | .id'
		}
	'';
}

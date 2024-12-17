{ ... }: {
	text = ''
		# Switch bottle.
		# Usage: bt <NAME>
		function bt() {
			export SHELL_NAME="''${*}"
		}

		# Create new bottle.
		# Usage: btc [ENV] [EXTRA]
		function btc() {
			local env="''${1}"
			[[ "''${env}" = "" ]] && env="gaming"
			bottles-cli new --bottle-name "''${SHELL_NAME}" --environment "''${env}" "''${@:2}"
		}

		# Run a file inside a bottle.
		# Usage: btre <EXE> [EXTRA]
		function btre() {
			bottles-cli run -b "''${SHELL_NAME}" -e "''${@}"
		}

		# Run a program inside a bottle.
		# Usage: btr <NAME> [EXTRA]
		function btr() {
			bottles-cli run -b "''${SHELL_NAME}" -p "''${@}"
		}

		# List bottles.
		function btl() {
			bottles-cli list bottles 2> /dev/null
		}

		# List programs in a bottle.
		function btlp() {
			bottles-cli programs -b "''${SHELL_NAME}" 2> /dev/null
		}

		# Add a program to bottle.
		# Usage: bta <NAME> <EXE> [EXTRA]
		function bta() {
			local name="''${1}"
			local exe=$(realpath "''${2}")
			if [[ "''${exe}" = "" ]]; then
				help bta
				return 2
			fi

			bottles-cli add -b "''${SHELL_NAME}" -n "''${name}" -p "''${exe}" "''${@:3}" 2> /dev/null
		}

		# Set bottle env var.
		# Usage: bte <NAME=VALUE>
		function bte() {
			local env="''${1}"
			if [[ "''${env}" = "" ]]; then
				help bte
				return 2
			fi

			bottles-cli edit -b "''${SHELL_NAME}" --env-var "''${@}" 2> /dev/null
		}

		# Play bottle.
		# Usage: btp <BOTTLE>
		function btp() {
			local bottle="''${1##*/}"
			if [[ "''${bottle}" = "" ]]; then
				help btp
				return 2
			fi

			local program=$(bottles-cli programs -b "''${bottle}" 2> /dev/null | sed -n -e "s/^- //; 2p")
			bottles-cli run -b "''${bottle}" -p "''${program}"
		}

		function _comp_bottles_list() {
			_autocomplete $(bottles-cli list bottles 2> /dev/null | sed -e "1d; s/^- //")
		}

		function _comp_programs_list() {
			local IFS=$'\n'
			_autocomplete $(bottles-cli programs -b "''${SHELL_NAME}" 2> /dev/null | sed -e "1d; s/^- //")
		}

		complete -F _comp_bottles_list bt btp
		complete -F _comp_programs_list btr
	'';
}

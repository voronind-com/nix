{ ... }: {
	text = ''
		# Ask general AI.
		# Usage: ask <QUERY>
		function ask() {
			curl http://localhost:11434/api/generate -d "{
				\"model\":\"''${OLLAMA_MODEL}\",
				\"raw\":true,
				\"prompt\":\"''${*}\"
			}" 2> /dev/null | parallel -j1 -- "printf '%s\n' {} | jq -r .response | sed -e 's/^$/\+\+\+/' | tr -d '\n' | sed -e 's/\+\+\+/\n/'"
			echo
		}

		# Specify ask model.
		function ask_model() {
			export OLLAMA_MODEL="''${1}"
		}

		function _complete_ask_model() {
			local IFS=$'\n'
			local models=($(ollama list | sed -e "1d" | cut -f1))
			_autocomplete ''${models[@]}
		}

		complete -F _complete_ask_model ask_model
	'';
}

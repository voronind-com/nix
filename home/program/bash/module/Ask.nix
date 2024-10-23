{ ... }:
{
  text = ''
    # Ask general AI.
    # Usage: ask <QUERY>
    function ask() {
      curl http://localhost:11434/api/generate -d "{
        \"model\": \"''${OLLAMA_MODEL}\",
        \"prompt\":\"''${*}\"
      }" 2> /dev/null | parallel -j1 -- "echo {} | jq -r .response | tr -d '\n'"
      echo
    }

    # Specify ask model.
    function ask_model() {
      export OLLAMA_MODEL="''${1}"
    }

    function _complete_ask_model() {
      local IFS=$'\n'
      local models=($(ollama list | sed -e "1d" | cut -f1))
      _autocomplete_first ''${models[@]}
    }

    complete -F _complete_ask_model ask_model
  '';
}

# Bash autocomplete.
# There are also options like -o nospace. see man for more info.
# Usage: _foo() { _autocomplete "{foo,bar}" } ; complete -F _foo foo
function _autocomplete() {
	local iter use cur
	cur=${COMP_WORDS[COMP_CWORD]}
	use="${@//\\ /___}"
	for iter in $use; do
		if [[ $iter =~ ^$cur ]]; then
			COMPREPLY+=($(printf "%q" "${iter//___/ }"))
		fi
	done
}

# Autocomplete by grepping file names.
function _autocomplete_grep() {
	local IFS=$'\n'
	COMPREPLY=()

	local pattern="${1}"
	local candidates=$("$(ls | grep -E ${pattern})")
	_autocomplete ${candidates}
}

# Autocomplete nested program.
function _autocomplete_nested() {
	# local IFS=$'\n'
	local cur prev words cword split i
	_init_completion -s || return

	for ((i = 1; i <= cword; i++)); do
		if [[ ${words[i]} != -* ]]; then
			local PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
			local root_command=${words[i]}
			_command_offset ${i}
			return
		fi
	done
}

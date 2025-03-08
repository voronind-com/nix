# Unset possible system-defined aliases.
unalias l ll lll llll la lla &>/dev/null
unset l ll lll llll la lla &>/dev/null

# List files in dirs.
# Current dir by default.
# Usage: l [DIRS]
function l() {
	# ls -lhv --si --group-directories-first --color=auto -- "$@"
	ccd "$@"
}

# List files using ls list.
# Current dir by default.
# Usage: ll [DIRS]
function ll() {
	ls -lhva --si --color=auto -- "$@"
}

# List files in tree structure.
# Current dir by default.
# Depth can be omitted by passing `-` (dash).
# Usage: lll [DEPTH] [DIRS]
function lll() {
	local IFS=$'\n'
	local depth="${1}"
	local target=("${@:2}")

	[[ ${target} == "" ]] && target="."
	[[ ${depth} == "" ]] && depth=666
	[[ ${depth} == "-" ]] && depth=666

	tree -a -L "${depth}" -- "${target[@]}"
}

# List files recursively.
# Current dir by default.
# Usage: llll [DIRS]
function llll() {
	ls -Rlahv --si --color=auto -- "$@"
}

# List files using ls list, sorted by mtime.
# Current dir by default.
# Usage: llm [DIRS]
function llm() {
	ls -lahtr --si --color=auto -- "$@"
}

# List only files.
function _ls_file() {
	ls --classify | grep -v \/$
}

# List only dirs.
function _ls_dir() {
	ls --classify | grep \/$ | sed -e "s/\/$//"
}

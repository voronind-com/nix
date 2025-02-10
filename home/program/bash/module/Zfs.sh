# Zfs list.
function zl() {
	eval "zfs list" "${@}"
}

# Zfs list snapshots.
function zls() {
	eval "zfs list -t snapshot" "${@}"
}

# Zfs list bookmarks.
function zlb() {
	eval "zfs list -t bookmark" "${@}"
}

# Zfs recursive bookmarks.
# Usage: zbr <SNAPSHOT>
function zbr() {
	local target="${1}"

	if [[ "${target}" = "" ]]; then
		help zbr
		return 2
	fi

	# local IFS=$'\n'
	local dataset="${target%%\@*}"
	local tag="${target##*\@}"
	local children=($(zfs list | rg "${dataset}" | cut -d\  -f1))

	for child in ${children[@]}; do
		zfs bookmark "${child}@${tag}" "${child}#${tag}"
	done
}

# Zfs recursive delete bookmarks.
# Usage: zbrd <BOOKMARK>
function zbrd() {
	local target="${1}"

	if [[ "${target}" = "" ]]; then
		help zbr
		return 2
	fi

	# local IFS=$'\n'
	local dataset="${target%%\#*}"
	local tag="${target##*\#}"
	local children=($(zfs list | rg "${dataset}" | cut -d\  -f1))

	for child in ${children[@]}; do
		zfs destroy "${child}#${tag}"
	done
}

# TODO: Autocompletes.

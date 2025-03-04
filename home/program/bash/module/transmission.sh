# Torrent download alias.
function tdl() {
	transmission-remote home.local "${@}"
}

# Download torrent files to home.
# Usage: tdla <FILES>
function tdla() {
	tdl --add "${@}"
}

# List download torrents.
function tdll() {
	tdl --list
}

# Remove torrent by id.
# Usage: tdlr <IDs>
function tdlr() {
	if [ "${*}" = "" ]; then
		help tdlr
		return 2
	fi
	local ids=$(printf "%s" "${*}" | tr ' ' ',')

	tdl -t"${ids}" --remove
}

# Remove and delete files torrent by id.
# Usage: tdlrd <IDs>
function tdlrd() {
	if [ "${*}" = "" ]; then
		help tdlr
		return 2
	fi
	local ids=$(printf "%s" "${*}" | tr ' ' ',')

	tdl -t"${ids}" --remove-and-delete
}

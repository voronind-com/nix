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
	transmission-remote home.local --list
}

# Remove torrent by id.
# Usage: tdlr <ID>
function tdlr() {
	tdl -t"${@}" --remove
}

# Remove and delete files torrent by id.
# Usage: tdlrd <ID>
function tdlrd() {
	tdl -t"${@}" --remove-and-delete
}

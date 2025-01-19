# Torrent download alias.
function tdl() {
	transmission-remote home.local "${@}"
}

# Download torrent files to home.
# Usage: tdla <FILES>
function tdla() {
	tdl -a "${@}"
}

# List download torrents.
function tdll() {
	transmission-remote home.local -l
}

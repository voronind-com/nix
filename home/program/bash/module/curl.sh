# Download a file from the web.
# Usaee: dl <FILE> [FILES...]
function dl() {
	wcurl --curl-options='--progress-bar --http2' -- "${@}"
}

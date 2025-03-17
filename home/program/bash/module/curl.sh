# Download a file from the web.
# Usaee: wdl <FILE> [FILES...]
function wdl() {
	wcurl --curl-options='--progress-bar --http2' -- "${@}"
}

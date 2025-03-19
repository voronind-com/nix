# Download a file from the web.
# Usaee: wdl <FILE> [FILES...]
function wdl() {
	wcurl --curl-options='--continue-at -' -- "${@}"
}

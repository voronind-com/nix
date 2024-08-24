{ ... }: {
	text = ''
		# Download a file from the web.
		# Usage: dl <FILE> [FILES...]
		function dl() {
			wcurl --curl-options='--http2 --continue-at -' -- ''${@}
		}
	'';
}

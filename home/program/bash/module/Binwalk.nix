{ ... }: {
	text = ''
		# Extract all formats with binwalk.
		# Use -M for recursive extract.
		# Usage: binwalke <FILES>
		function binwalke() {
			binwalk --dd='.*' "$@"
		}
	'';
}

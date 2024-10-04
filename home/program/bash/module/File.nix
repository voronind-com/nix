{ ... }: {
	text = ''
		# Open file/dir in GUI.
		# Usage: o <FILE>
		function o() {
			xdg-open "''${@}"
		}

		# Play media file from CLI. All files by default.
		# Usage: play [FILE]
		function play() {
			local targets=''${*}
			[[ "''${targets}" = "" ]] && targets=$(_ls_file)

			mpv --no-video ''${targets}
		}

		# Play media files shuffled from CLI. All files by default.
		# Usage: play_shuffle [FILE]
		function play_shuffle() {
			local targets=''${*}
			[[ "''${targets}" = "" ]] && targets=$(_ls_file)

			mpv --no-video --shuffle ''${targets}
		}

		# Open files app.
		function files() {
			nautilus
		}
	'';
}

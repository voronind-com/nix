{ ... }: {
	text = ''
		export VDL_PROXY="--proxy 'socks5://10.0.0.1:1080/' "

		# Download video from URL. When no `[LINK]` specified, it tries to update previously downloaded link.
		# Usage: vdl [LINK]
		function vdl() {
			# Check that ffmpeg and ffprobe are available.
			if [[ "$(ffmpeg -version)" = "" ]] || [[ "$(ffprobe -version)" = "" ]]; then
				_error "ffmpeg and ffprobe are required."
				return 1
			fi

			local target="''${@}" # What to download/update.

			# If no [LINK] provided, try to read from `Src.txt`.
			[[ "''${target}" = "" ]] && target="$(cat Src.txt)"

			# If could not get [LINK] eventually, show an error and exit.
			if [[ "''${target}" = "" ]]; then
				_error "Could not determine [LINK] to download."
				help vdl
				return 2
			fi

			# Save [LINK] for later use.
			[[ -f "Src.txt" ]] || echo "''${target}" > Src.txt

			# Download [LINK] content.
			yt-dlp ''${VDL_PROXY} -S 'res:1080,codec:av1,codec:vp9,codec:h264' --download-archive Index.txt --embed-thumbnail --embed-subs --write-auto-subs --embed-metadata --merge-output-format mkv -cio '%(playlist_index)000006d_%(id)s.%(ext)s' ''${target} # || _vdl_retry
		}

		# Temporary fix for vk downloads.
		# Usage: vdl_vk <LINK>
		function vdl_vk() {
			vdl --format mp4 "''${@}"
		}

		# Download all videos from file with links.
		# Usage: vdl_file <FILE>
		function vdl_file() {
			vdl -a "''${@}"
		}
	'';
}

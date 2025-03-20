# Download video from URL. When no `[LINK]` specified, it tries to update previously downloaded link.
# Usage: vdl [LINK]
function vdl() {
	# Check that ffmpeg and ffprobe are available.
	if [[ "$(ffmpeg -version)" == "" ]] || [[ "$(ffprobe -version)" == "" ]]; then
		_error "ffmpeg and ffprobe are required."
		return 1
	fi

	local target="${@}" # What to download/update.

	# If no [LINK] provided, try to read from `Src.txt`.
	[[ ${target} == "" ]] && target="$(cat src.txt)"

	# If could not get [LINK] eventually, show an error and exit.
	if [[ ${target} == "" ]]; then
		_error "Could not determine [LINK] to download."
		help vdl
		return 2
	fi

	# Save [LINK] for later use.
	[[ -f "src.txt" ]] || echo "${target}" >src.txt

	# Download [LINK] content.
	eval "yt-dlp -4 -S 'res:1080,codec:av1,codec:vp9,codec:h264' --download-archive index.txt --embed-thumbnail --embed-subs --write-auto-subs --embed-metadata --merge-output-format mkv -cio '%(playlist_index)000006d_%(id)s.%(ext)s'" "${target}"
}

# Download all videos from file with links.
# Usage: vdl_file <FILE>
function vdl_file() {
	vdl -a "${@}"
}

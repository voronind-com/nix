# Mux audio into containers. File names in sound and current dirrectories must match.
# Usage: ffmpeg_mux_audio <SOUND> <OUTPUT DIR>
function ffmpeg_mux_audio() {
	if [[ ${1} == "" ]]; then
		help ffmpeg_mux_audio
		return 2
	fi

	for file in *; do ffmpeg -i "$file" -i "$1"/"$file" -c copy -map 0:v:0 -map 1:a:0 -shortest "$2"/"$file"; done
}

# Mux cover into music file.
# Usage: ffmpeg_mux_cover <FORMAT> <COVER>
function ffmpeg_mux_cover() {
	if [[ ${1} == "" ]]; then
		help ffmpeg_mux_cover
		return 2
	fi

	local format="${1}"
	local cover="${2}"

	mkdir out

	case "${format}" in
	# "mka"|"mkv")
	#   for file in *.${format}; do
	#     ffmpeg -i "${file}" -attach "${cover}" -map 0 -c copy -metadata:s:t mimetype="image/${cover##*.}" -metadata:s:t:0 filename="cover.${cover##*.}" "./out/${file}" || return 1
	#   done
	#   ;;
	*)
		for file in *.${format}; do
			# ffmpeg -i "${file}" -i "${cover}" -map 0 -map 0:-v? -map 1 -codec copy -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" -disposition:v attached_pic ./out/"${file}" || return 1
			ffmpeg -i "${file}" -i "${cover}" -map 0 -map 1 -codec copy -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)" -disposition:v attached_pic ./out/"${file}" || return 1
		done
		;;
	esac

	mv out/* .
	rm -d out/ # && rm "${2}"
}

# Generate music metadata from directory structure.
# Top dir is the Artist name like this: `The_Beatles`.
# Next are albums like this: `2010_My_love`.
# Inside are songs like this: `01_sample.flac`.
# Usage: ffmpeg_music_meta <FORMAT>
function ffmpeg_music_meta() {
	if [[ ${1} == "" ]]; then
		help ffmpeg_music_meta
		return 2
	fi

	local format="${1}"

	ls *.${format} &>/dev/null || return 1

	local artist="${PWD%/*}"
	artist="${artist##*/}"
	artist="${artist//_/ }"
	local album="${PWD##*/}"
	album="${album#*_}"
	album="${album//_/ }"
	local year="${PWD##*/}"
	year="${year%%_*}"
	# local total=$(ls *.${format} | wc -l)

	# Check.
	if [[ ${album} == "" ]]; then
		_error "Failed to get the album name!"
		return 1
	fi
	if [[ ${artist} == "" ]]; then
		_error "Failed to get the artist name!"
		return 1
	fi
	if [[ ${year} == "" ]]; then
		_error "Failed to get the year!"
		return 1
	fi

	mkdir out

	for file in *.${format}; do
		local track="${file%%_*}"
		track=$((10#${track}))
		local title="${file#*_}"
		title="${title%.*}"
		title="${title//_/ }"

		if [[ ${track} == "" ]]; then
			_error "Failed to get the track number!"
			return 1
		fi
		if [[ ${title} == "" ]]; then
			_error "Failed to get the title name!"
			return 1
		fi

		# echo "${artist}; ${album}; ${year}; ${track}; ${title}"
		# TODO: make it format-specific.
		ffmpeg -i "${file}" -map 0 -c copy -metadata "artists=" -metadata "artist=${artist}" -metadata "album_artist=${artist}" -metadata "album=${album}" -metadata "date=${year}" -metadata "year=${year}" -metadata "date_released=${year}" -metadata "track=${track}" -metadata "part_number=${track}" -metadata "title=${title}" ./out/"${file}" || return 1
	done

	mv out/* .
	rm -d out/
}

# Rotate the video clock-wise.
# Usage: ffmpeg_rotate <ANGLE> <TARGET>
function ffmpeg_rotate() {
	if [[ ${2} == "" ]]; then
		help ffmpeg_rotate
	fi

	local angle="${1}"
	local target="${2}"

	ffmpeg -display_rotation ${angle} -i ${target} -c copy _${target} && mv _${target} ${target} || rm _${target}
}

# Get video FPS.
function _ffprobe_fps() {
	local fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "${1}")
	[[ ${fps} == "" ]] && fps=30 || fps=$((fps))
	echo "${fps}"
}

# Get recommended keyframe interval for a file.
function _ffprobe_keyint() {
	local fps=$(_ffprobe_fps "${1}")
	echo $((fps * 5))
}

# Get audio bitrage. 128 by default.
function _ffprobe_ba() {
	local ba=$(ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "${1}")
	[[ ${ba} != "N/A" ]] && echo $((ba / 1024)) || echo 128
}

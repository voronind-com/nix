# Convert between different formats.
# By default tries to convert all files.
# Usage: transcode <FORMAT> [FILES]
function transcode() {
	local IFS=$'\n'
	local format=${1}
	local targets=(${@:2})
	[[ ${targets} == "" ]] && targets=($(_ls_file))

	# Report no format.
	if [[ ${format} == "" ]] || [[ ${format} =~ "." ]]; then
		_error "No format specified."
		help transcode
		return 2
	fi

	process() {
		# Define context names and status.
		local from="${target##*.}"
		local to="${format}"
		local output="${target##*/}"
		output="${output%.*}.${to}"

		# Skip if file exists.
		[[ -f ${output} ]] && {
			_iterate_skip "Already exists."
			return 0
		}

		# Support multiple inputs.
		[[ ${to} == "flac" ]] && from=""
		[[ ${to} == "jxl" ]] && from=""
		[[ ${to} == "mka" ]] && from=""
		[[ ${to} == "mkv" ]] && from=""
		[[ ${to} == "mp3" ]] && from=""

		# Send convert.
		case "${from}-${to}" in
		"gz-xz" | "tgz-txz")
			_transcode_gz-xz "${target}" "${output}"
			;;
		"xz-gz" | "txz-tgz")
			_transcode_xz-gz "${target}" "${output}"
			;;
		"-mp3")
			_transcode_mp3 "${target}" "${output}"
			;;
		"-flac")
			_transcode_flac "${target}" "${output}"
			;;
		"-mka")
			_transcode_mka "${target}" "${output}"
			;;
		"-mkv")
			_transcode_mkv "${target}" "${output}"
			;;
		"-jxl")
			_transcode_jxl "${target}" "${output}"
			;;
		*)
			_error "Conversion ${target##*.}-${to} not supported."
			return 1
			;;
		esac
	}

	_iterate_targets process ${targets[@]}
}

function _transcode_gz-xz() {
	[[ -f ${2} ]] && return 1
	pv "${1}" | gzip -d | xz -9e >"${2}"
}

function _transcode_xz-gz() {
	[[ -f ${2} ]] && return 1
	pv "${1}" | xz -d | gzip -1 >"${2}"
}

function _transcode_mp3() {
	ffmpeg -n -i "${1}" -c:a libmp3lame -f mp3 "${2}"
}

function _transcode_flac() {
	ffmpeg -n -i "${1}" -c:a flac -f flac "${2}"
}

function _transcode_mka() {
	# local braudio=$(_ffprobe_ba "${1}")
	# [[ ${braudio} -gt 128 ]] && braudio=128

	# ffmpeg -n -i "${1}" -ac 2 -c:a libopus -b:a ${braudio}k -vn "${2}"
	ffmpeg -n -i "${1}" -ac 2 -c:a libopus -vn "${2}"
}

function _transcode_mkv() {
	# local keyint=$(_ffprobe_keyint "${1}")
	# local braudio=$(_ffprobe_ba "${1}")
	# local fps=$(_ffprobe_fps "${1}")
	# [[ ${braudio} -gt 128 ]] && braudio=128
	# [[ ${fps} -gt 30 ]] && fps=30

	# ffmpeg -n -i "${1}" -c:a libopus -b:a ${braudio}k -c:v libsvtav1 -crf 30 -svtav1-params "fast-decode=1:tune=0" -preset 8 -pix_fmt yuv420p10le -g ${keyint} -vf "scale=-2:min'(1080,ih)'" "${2}"
	# ffmpeg -n -i "${1}" -map 0 -map -v -map V -map -t -dn -c:s srt -ac 2 -c:a libopus -b:a ${braudio}k -c:v libsvtav1 -crf 30 -svtav1-params "tune=0" -pix_fmt yuv420p10le -g ${keyint} -vf "scale=-2:min'(1080,ih)' , fps=${fps}" "${2}"
	ffmpeg -n -i "${1}" -map 0 -map -v -map V -map -t -dn -c:s srt -ac 2 -c:a libopus -c:v libsvtav1 "${2}"
}

function _transcode_jxl() {
	cjxl -e 9 --lossless_jpeg=1 -- "${1}" "${2}"
}

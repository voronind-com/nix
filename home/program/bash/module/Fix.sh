# Fix when ethernet mistakenly detects 100 Mb instead of 1000 Mb.
# SPEED is one of 10/100/1000 etc.
# Usage: fix_ethernet_speed <DEVICE> <SPEED>
function fix_ethernet_speed() {
	local device="${1}"
	local speed="${2}"

	if [[ ${device} == "" || ${speed} == "" ]]; then
		help fix_ethernet_speed
		return 2
	fi

	ethtool -s "${device}" speed "${speed}"
}

# Fix pdfs when they don't want to be uploaded to Paperless.
# Usage: fix_pdf [FILES]
function fix_pdf() {
	local IFS=$'\n'
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=("*.pdf")

	process() {
		qpdf --replace-input "${target}"
	}

	_iterate_targets process ${targets[@]}
}

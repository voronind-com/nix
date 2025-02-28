# Show only physical drives info.
function pdf() {
	df --si | sed -e '1p' -e '/^\/dev\//!d'
}

# Show total size in SI.
# Current dir by default.
# Usage: tdu [DIRS]
function tdu() {
	printf "\nDisk:\n"
	du -sh --si "${@}"
	printf "\nReal:\n"
	du -sh --si --apparent-size "${@}"
}

# Find disk ids.
# Usage: fdid <SDx>
function fdid() {
	local sdx="${1}"
	if [ "${sdx}" = "" ]; then
		help fdid
		return 2
	fi

	for file in /dev/disk/by-id/*; do
		if [[ "$(readlink ${file})" =~ ${sdx} ]]; then
			printf "%s\n" "${file}"
		fi
	done
}

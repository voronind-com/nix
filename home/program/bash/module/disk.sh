# Show only physical drives info.
function pdf() {
	df --si | sed -e '1p' -e '/^\/dev\//!d'
}

# Show total size in SI.
# Current dir by default.
# Usage: tdu [DIRS]
function tdu() {
	_tdu() {
		local IFS=$'\n'
		local targets=("${@}")
		[ "${targets}" = "" ] && targets=(".")
		printf "Path\tReal\tDisk\n"
		printf "%s\t%s\t%s\n" "----" "----" "----"
		for target in ${targets[@]}; do
			local real=$(du -s --si --apparent-size "${target}" | cut -f1)
			local disk=$(du -s --si "${target}" | cut -f1)
			printf "${target}\t${real}\t${disk}\n"
		done
	}
	_tdu "${@}" | column -t -s $'\t'
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

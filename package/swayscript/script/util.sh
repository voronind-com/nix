# Find currently active SWAYSOCK paths.
function _sway_find_sockets() {
	ls /run/user/${UID}/sway-ipc.${UID}.*.sock
}

function _sway_iterate_sockets() {
	local IFS=$'\n'
	for socket in $(_sway_find_sockets); do
		SWAYSOCK="${socket}" ${1}
	done
}

function _index_of() {
	local element="${1}"
	local array="${@:2}"
	local index=0

	for item in ${array[@]}; do
		[[ ${item} == "${element}" ]] && break
		((index++))
	done

	echo "${index}"
}

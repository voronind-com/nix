# Change file ownership to specified user id and restrict access to him.
# Root user by default. This directory recursively by default.
# Usage: own [USER] [FILES]
function own() {
	local IFS=$'\n'
	local files=("${@:2}")
	local user="${1}"
	local group="${1}"

	# Default to current dir.
	if [ "${files[*]}" = "" ]; then
		files=(".")
	fi

	# Default to current user.
	if [ "${user}" = "" ]; then
		user="${UID}"
	fi

	# If not root, default to users group.
	[[ ${user} == 0 ]] && group="0" || group="100"

	for file in "${files[@]}"; do
		# set ownership.
		chown "${user}":"${group}" -R "${file}" &>/dev/null

		# remove access from group and others.
		# chmod -077 -R "${file}"
	done
}

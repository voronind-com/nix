# Run something recursively over all directories.
# Usage: recursive <COMMAND>
function recursive() {
	if [[ ${*} == "" ]]; then
		help recursive
		return 2
	fi

	eval _recursive 0 99999 ${*}
}

# Run something recursively over directories of 1 depth (excluding current dir).
# Usage: recursive1 <COMMAND>
function recursive1() {
	if [[ ${*} == "" ]]; then
		help recursive1
		return 2
	fi

	eval _recursive 1 1 ${*}
}

# Usage: _recursive <MINDEPTH> <MAXDEPTH> <CMD>
function _recursive() {
	local IFS=$'\n'
	local mindepth=${1}
	local maxdepth=${2}
	local cmd=${@:3}
	local current="${PWD}"
	local dirs=$(find -mindepth ${mindepth} -maxdepth ${maxdepth} -type d)
	local total=$(printf "%s\n" ${dirs[@]} | wc -l)
	local count=0
	local failed=0

	for dir in ${dirs}; do
		# Increment counter.
		((count++))

		# Echo status.
		echo -e "\n${color_bblue}[${count}/${total}] ${dir}${color_default}"

		# Cd into the next dir.
		cd "${current}" || {
			failed=${?}
			continue
		}
		cd "${dir}" || {
			failed=${?}
			continue
		}

		# Run command.
		eval ${cmd} || failed=${?}
	done

	# return back on complete.
	cd "${current}" || failed=${?}

	return ${failed}
}

# autocomplete.
complete -F _autocomplete_nested recursive recursive1

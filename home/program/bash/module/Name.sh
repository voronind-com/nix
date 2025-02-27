# Rename dirs to `snake_case` and files to `Start_Case`
# Usage: name [FILES]
function name() {
	local IFS=$'\n'
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=($(ls))

	process() {
		if [[ -d ${target} ]]; then
			local new_name=$(parse_snake ${target})
			[ "${target}" = "${new_name}" ] && return 0
			[[ -e ${new_name} ]] && {
				_error "${new_name}: Already exists!"
				return 1
			}

			mv -- ${target} ${new_name} && echo ${new_name}
		else
			local ext=".${target##*.}"
			local name=${target%.*}
			[[ ${ext} == ".${target}" ]] && ext=""

			local new_name="$(parse_startcase $(parse_snake ${name}))${ext}"
			[ "${target}" = "${new_name}" ] && return 0
			[[ -e ${new_name} ]] && {
				_error "${new_name}: Already exists!"
				return 1
			}

			mv -- ${target} ${new_name} && echo ${new_name}
		fi
	}

	_iterate_targets process ${targets[@]}
}

# Rename files with provided parser, i.e. `parse_simple`.
# All files by default.
# Usage: name_parse <PARSER> [FILES]
function name_parse() {
	local IFS=$'\n'
	local parser=${1}
	local targets=(${@:2})
	[[ ${targets} == "" ]] && targets=("[^.]*")

	if [[ ${parser} == "" ]]; then
		help name_parse
		return 2
	fi

	process() {
		# parse new name.
		local ext=""
		local name="${target}"

		# ext only for files.
		if [[ -f ${target} ]]; then
			ext=".${target##*.}"
			name="${target%.*}"
		fi

		# Files w/o extension support.
		[[ ${ext#.} == "${name}" ]] && ext=""

		# Get new name.
		local new_name=$(${parser} "${name}")${ext,,}

		# check if same name.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# rename target.
		mv -- "${target}" "${new_name}" && echo "${new_name}"
	}

	_iterate_targets process ${targets[@]}
}

# Rename all files to their hashes while keeping extensions.
# All files by default.
# Usage: name_hash [FILES]
function name_hash() {
	local IFS=$'\n'
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=($(_ls_file))

	process() {
		# Extract extension.
		local extension="${target##*.}"
		if [[ ${extension} == "${target}" ]]; then
			extension=""
		else
			extension=".${extension}"
		fi

		# Hash the new name.
		local hash=$(pv "${target}" | sha1sum | cut -d\  -f1)
		new_name="${hash,,}${extension,,}"

		# Check if same name.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# rename target.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Check hashes for previously renamed files.
# All files by default.
# Usage: name_hash_check [FILES]
function name_hash_check() {
	local IFS=$'\n'
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=("[^.]*")

	process() {
		# extract hashes.
		local stored="${target%%.*}"
		local actual=$(pv "${target}" | sha1sum | cut -d\  -f1)

		# compare hashes.
		if [[ ${stored} != "${actual}" ]]; then
			_error "Failed."
			return 1
		fi
	}

	_iterate_targets process ${targets[@]}
}

# Rename files for Jellyfin shows, i.e. `Episode S01E01.mkv`
# All files by default.
# Usage: name_show [FILES]
function name_show() {
	local IFS=$'\n'
	local season="$(realpath .)"
	season="${season##*\ }"
	local episode=0
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=($(_ls_file))

	# Error when no season number specified.
	if [[ ${season} == "" ]]; then
		_error "Could not determine season number."
		return 2
	fi

	process() {
		((episode++))

		# extract new name.
		local new_name="Episode S${season}E$(printf %02d ${episode}).${target##*.}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# rename target.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Rename files for Kavita manga format.
# All files by default.
# Usage: name_manga <SEASON> [FILES]
function name_manga() {
	local IFS=$'\n'
	local manga=${PWD##*/}
	local season=${1}
	local episode=0
	local targets=(${@:2})
	[[ ${targets} == "" ]] && targets=($(_ls_file))

	# Error when no season number specified.
	if [[ ${season} == "" ]]; then
		help name_manga
		return 2
	fi

	process() {
		((episode++))

		# Extract new name.
		local new_name="${manga} Vol.${season} Ch.${episode}.${target##*.}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# Rename target.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Rename files with new extension.
# All files by default.
# Usage: name_ext <EXTENSION> [FILES]
function name_ext() {
	local IFS=$'\n'
	local extension=${1}
	local targets=(${@:2})
	[[ ${targets} == "" ]] && targets=($(_ls_file))

	# Error when no new extension specified.
	if [[ ${extension} == "" ]]; then
		help name_ext
		return 2
	fi

	process() {
		# Extract new name.
		local new_name="${target%.*}"."${extension}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# Rename target.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Change file name prefix.
# All matching files by default.
# Usage: name_prefix <OLD> <NEW> [FILES]
function name_prefix() {
	local IFS=$'\n'
	local old=${1}
	local new=${2}
	local targets=(${@:3})
	[[ ${targets} == "" ]] && targets=(${old}*)

	process() {
		# Create new name.
		local new_name="${new}${target#$old}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# Rename.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Change file name postfix.
# All matching files by default.
# Usage: name_postfix <OLD> <NEW> [FILES]
function name_postfix() {
	local IFS=$'\n'
	local old=${1}
	local new=${2}
	local targets=(${@:3})
	[[ ${targets} == "" ]] && targets=(*${old})

	process() {
		# Create new name.
		local new_name="${target%$old}${new}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# Rename.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Replace part of the name.
# All matching files by default.
# Usage: name_replace <OLD> <NEW> [FILES]
function name_replace() {
	local IFS=$'\n'
	local old=${1}
	local new=${2}
	local targets=(${@:3})
	[[ ${targets} == "" ]] && targets=(*${old}*)

	process() {
		# Create new name.
		local new_name="${target//$old/$new}"

		# Skip on no change.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		# Rename.
		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Fix numbering for numbered files. I.e if there are 10 items and some of them start without zero, then append zero to it. 1..10 -> 01..10.
# Usage: name_fix_numbering [FILES]
function name_fix_numbering() {
	local IFS=$'\n'
	local highest=0
	local power=0
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=($(ls | grep "^[0-9]"))

	# Count leading zeroes.
	for target in "${targets[@]}"; do
		# Check that starts with a digit.
		[[ ${target} =~ ^[0-9] ]] || continue

		local digits=($(parse_ints "${target}"))
		local digit="${digits[0]}"
		digit=$((10#${digit}))

		[[ ${digit} -gt ${highest} ]] && highest="${digit}"
	done

	local i=${highest}
	while [[ i -gt 0 ]]; do
		((power++))
		i=$((i / 10))
	done

	process() {
		# Check that starts with a digit.
		if [[ ! ${target} =~ ^[0-9] ]]; then
			_error "Does not start with a digit!"
			return 1
		fi

		# Prepare new name.
		local digits=($(parse_ints "${target}"))
		local digit="${digits[0]}"
		digit=$((10#${digit}))
		local new_name=$(printf "%0${power}d" "${digit}")"${target#${digits[0]}}"

		# Skip if the same name.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

# Create numbering for unnumbered files.
# Usage: name_make_numbering [FILES]
function name_make_numbering() {
	local IFS=$'\n'
	local power=0
	local targets=(${@})
	[[ ${targets} == "" ]] && targets=(*)

	# Count leading zeroes.
	count=${#targets[@]}
	while [ ${count} -gt 0 ]; do
		((power++))
		count=$((count / 10))
	done

	local iter=0
	process() {
		((iter++))

		# Prepare new name.
		local digits=($(parse_ints "${target}"))
		local digit="${digits[0]}"
		local new_name=$(printf "%0${power}d" "${iter}")"_${target#${digit}_}"

		# Skip if the same name.
		[ "${target}" = "${new_name}" ] && return 0
		[[ -e ${new_name} ]] && {
			_error "${new_name}: Already exists!"
			return 1
		}

		mv -- ${target} ${new_name} && echo ${new_name}
	}

	_iterate_targets process ${targets[@]}
}

function _comp_name_parse() {
	_autocomplete $(find_function | grep ^parse)
}

complete -o filenames -F _comp_name_parse name_parse

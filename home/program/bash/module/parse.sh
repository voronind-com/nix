export _PARSE_ALLOWED_CHARS="_-"
export _PARSE_SPLIT_CHARS="\.\ "

# Parse data and output simplified format.
# Usage: parse_simple <STRING>
function parse_simple() {
	sed -E \
		-e "s/[${_PARSE_SPLIT_CHARS}]/${_PARSE_ALLOWED_CHARS:0:1}/g" \
		-e "s/[^[:alnum:]${_PARSE_ALLOWED_CHARS}]//g" \
		-e "s/([${_PARSE_ALLOWED_CHARS}])[${_PARSE_ALLOWED_CHARS}]+/\1/g" \
		-e "s/^[${_PARSE_ALLOWED_CHARS}]//" -e "s/[${_PARSE_ALLOWED_CHARS}]$//"
}

# Parse to PascalCase.
# Usage: parse_pascal <STRING>
function parse_pascal() {
	local parts=($(_parse_split_strip))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		word="${word^}"
		result="${result}${word}"
	done

	printf "%s" "${result}" | parse_simple
}

# Parse to snake_case.
# Usage: parse_snake <STRING>
function parse_snake() {
	local parts=($(_parse_split_strip))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		result="${result}_${word}"
	done

	printf "%s" "${result#_}" | parse_simple
}

# Parse to kebab-case.
# Usage: parse_kebab <STRING>
function parse_kebab() {
	local parts=($(_parse_split_strip))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		result="${result}-${word}"
	done

	printf "%s" "${result#-}" | parse_simple
}

# Parse to camelCase.
# Usage: parse_camel <STRING>
function parse_camel() {
	local parts=($(_parse_split_strip))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		word="${word^}"
		result="${result}${word}"
	done

	printf "%s" "${result,}" | parse_simple
}

# Parse to SNAKE_CASE_UPPERCASE. **NOT STABLE! Repeating results in different output.**
# Usage: parse_snake_uppercase <STRING>
function parse_snake_uppercase() {
	local parts=($(_parse_split_strip))
	local result

	for part in "${parts[@]}"; do
		local word="${part^^}"
		result="${result}_${word}"
	done

	printf "%s" "${result#_}" | parse_simple
}

# Parse data keeping only alphanumeric characters.
# Usage: parse_alnum <STRING>
function parse_alnum() {
	sed -e "s/[^[:alnum:]]//g"
}

# Parse integers from mixed string.
# Usage: parse_ints <STRING>
function parse_ints() {
	tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g'
}

# Parse string to lowercase.
# Usage: parse_lowercase <STRING>
function parse_lowercase() {
	tr '[:upper:]' '[:lower:]'
}

# Parse string to uppercase.
# Usage: parse_uppercase <STRING>
function parse_uppercase() {
	tr '[:lower:]' '[:upper:]'
}

# Parse string to sentence case.
# Usage: parse_sentencecase <STRING>
function parse_sentencecase() {
	local input="$(cat)"
	local lower="${input,,}"
	printf "%s" "${lower^}"
}

# Parse string to start case.
# Usage: parse_startcase <STRING>
function parse_startcase() {
	local IFS=$'\n'
	local parts=($(parse_lowercase | _parse_split))

	for part in ${parts[@]}; do
		echo -n "${part^}"
	done

	echo
}

# Parse filename.
# Usage: parse_filename <STRING>
function parse_filename() {
	local parts=($(_parse_split))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		result="${result}_${word}"
	done

	printf "%s" "${result#_}" | parse_simple
}

# Split string by separators.
# Usage: _parse_split <STRING>
function _parse_split() {
	sed -e "s/[A-Z]\+/\n&/g" -e "s/[0-9]\+/\n&\n/g" -e "s/[${_PARSE_SPLIT_CHARS}${_PARSE_ALLOWED_CHARS}]/&\n/g" | sed -e "/^$/d"
}

# Split string by separators and strip separation chars.
function _parse_split_strip() {
	_parse_split | sed -e "s/[${_PARSE_SPLIT_CHARS}]//g" | sed -e "/^$/d"
}

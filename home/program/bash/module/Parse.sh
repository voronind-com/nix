export _PARSE_ALLOWED_CHARS="_-"
export _PARSE_SPLIT_CHARS="\.\ "

# Parse data and output simplified format.
# Usage: parse_simple <STRING>
function parse_simple() {
	echo "${*}" | sed -E \
		-e "s/[${_PARSE_SPLIT_CHARS}]/${_PARSE_ALLOWED_CHARS:0:1}/g" \
		-e "s/[^[:alnum:]${_PARSE_ALLOWED_CHARS}]//g" \
		-e "s/([${_PARSE_ALLOWED_CHARS}])[${_PARSE_ALLOWED_CHARS}]+/\1/g" \
		-e "s/^[${_PARSE_ALLOWED_CHARS}]//" -e "s/[${_PARSE_ALLOWED_CHARS}]$//"
}

# Parse to PascalCase.
# Usage: parse_pascal <STRING>
function parse_pascal() {
	local parts=($(_parse_split "${*}"))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		word="${word^}"
		result="${result}${word}"
	done

	parse_simple "${result}"
}

# Parse to snake_case.
# Usage: parse_snake <STRING>
function parse_snake() {
	local parts=($(_parse_split "${*}"))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		result="${result}_${word}"
	done

	parse_simple "${result#_}"
}

# Parse to kebab-case.
# Usage: parse_kebab <STRING>
function parse_kebab() {
	local parts=($(_parse_split "${*}"))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		result="${result}-${word}"
	done

	parse_simple "${result#-}"
}

# Parse to camelCase.
# Usage: parse_camel <STRING>
function parse_camel() {
	local parts=($(_parse_split "${*}"))
	local result

	for part in "${parts[@]}"; do
		local word="${part,,}"
		word="${word^}"
		result="${result}${word}"
	done

	parse_simple "${result,}"
}

# Parse to SNAKE_CASE_UPPERCASE. **NOT STABLE! Repeating results in different output.**
# Usage: parse_snake_uppercase <STRING>
function parse_snake_uppercase() {
	local parts=($(_parse_split "${*}"))
	local result

	for part in "${parts[@]}"; do
		local word="${part^^}"
		result="${result}_${word}"
	done

	parse_simple "${result#_}"
}

# Parse data keeping only alphanumeric characters.
# Usage: parse_alnum <STRING>
function parse_alnum() {
	echo "${*}" | sed -e "s/[^[:alnum:]]//g"
}

# Parse integers from mixed string.
# Usage: parse_ints <STRING>
function parse_ints() {
	echo "${*}" | tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g'
}

# Parse string to lowercase.
# Usage: parse_lowercase <STRING>
function parse_lowercase() {
	echo "${*,,}"
}

# Parse string to uppercase.
# Usage: parse_uppercase <STRING>
function parse_uppercase() {
	echo "${*^^}"
}

# Parse string to sentence case.
# Usage: parse_sentencecase <STRING>
function parse_sentencecase() {
	local lower="${*,,}"
	echo "${lower^}"
}

# Parse string to start case.
# Usage: parse_startcase <STRING>
function parse_startcase() {
	local IFS=$'\n'
	local lower="${*,,}"
	local parts=($(_parse_split ${lower}))

	for part in ${parts[@]}; do
		echo -n "${part^}"
	done

	echo
}

# Split string by separators.
# Usage: _parse_split <STRING>
function _parse_split() {
	parse_simple "${*}" | sed -e "s/[A-Z]\+/\n&/g" -e "s/[0-9]\+/\n&\n/g" -e "s/[${_PARSE_SPLIT_CHARS}${_PARSE_ALLOWED_CHARS}]/&\n/g" | sed -e "/^$/d"
}

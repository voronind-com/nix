# Find all file extensions.
function find_ext() {
	local all=($(find -type f | sed -e "s/.*\///" -e "/\./!d" -e "s/.*\.//"))
	declare -A types
	for type in ${all[@]}; do
		((types[${type}]++))
	done

	local result=()
	for type in ${!types[@]}; do
		result+=("${type} ${types[${type}]}")
	done

	local IFS=$'\n'
	printf "%s\n" ${result[@]} | sort
}

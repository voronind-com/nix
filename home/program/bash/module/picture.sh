# Quick edit a picture and copy to clipboard.
# Usage: pic_copy <FILE>
function pic_copy() {
	swappy -f "${1}" -o - | copy
}

# Quick edit a pictures inplace.
# Usage: pic_edit <FILES>
function pic_edit() {
	local IFS=$'\n'
	for file in "${@}"; do
		swappy -f "${file}" -o "${file}"
	done
}

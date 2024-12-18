# Show only physical drives info.
function pdf() {
	df --si | sed -e '1p' -e '/^\/dev\//!d'
}

# Show total size in SI.
# Current dir by default.
# Usage: tdu [DIRS]
function tdu() {
	du -sh --si "${@}"
}

# Unlock encrypted disk file.
# Usage: funlock <FILE>
function funlock() {
	local file="${1}"

	if [[ ${file} == "" ]]; then
		help funlock
		return 2
	fi

	local name=$(parse_alnum "${file##*/}")

	local loop=$(udisksctl loop-setup --no-user-interaction --file "${file}")
	loop="${loop##* }"
	loop="${loop%.}"

	local decrypted=$(udisksctl unlock --block-device "${loop}")
	decrypted="${decrypted##* }"
	decrypted="${decrypted%.}"

	local mount=$(udisksctl mount --no-user-interaction --block-device "${decrypted}")
	mount="${mount#* at }"

	ya pub dds-cd --str "${mount}" 2>/dev/null
	cd "${mount}"
}

# Mount file.
# Usage: fmount <FILE>
function fmount() {
	local file="${1}"
	if [[ ${file} == "" ]]; then
		help fmount
		return 2
	fi

	local loop=$(udisksctl loop-setup --no-user-interaction --file "${file}")
	loop="${loop##* }"
	loop="${loop%.}"

	local mount=$(udisksctl mount --no-user-interaction --block-device "${loop}")
	mount="${mount#* at }"

	ya pub dds-cd --str "${mount}" 2>/dev/null
	cd "${mount}"
}

# Unmount file.
# Usage: fumount <LOOPDEVICE>
function fumount() {
	local loop="${1}"
	if [[ ${loop} == "" ]]; then
		help fumount
		return 2
	fi

	udisksctl unmount --no-user-interaction --block-device "${loop}"
	udisksctl loop-delete --no-user-interaction --block-device "${loop}"
}

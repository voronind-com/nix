# Fix when ethernet mistakenly detects 100 Mb instead of 1000 Mb.
# SPEED is one of 10/100/1000 etc.
# Usage: fix_ethernet_speed <DEVICE> <SPEED>
function fix_ethernet_speed() {
	local device="${1}"
	local speed="${2}"

	if [[ ${device} == "" || ${speed} == "" ]]; then
		help fix_ethernet_speed
		return 2
	fi

	ethtool -s "${device}" speed "${speed}"
}

# Delete lost Gradle lock files.
function fix_gradle_lock() {
	cd "${HOME}/.gradle" && find -type f | grep \\.lock$ | xargs -- rm
	cd -
}

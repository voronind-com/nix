# Toggle vpn.
function vpn() {
	if [[ "$(_vpn)" == "on" ]]; then
		nmcli connection down Vpn
		notify_long
	else
		nmcli connection up Vpn
		notify_short
	fi
}

function _vpn() {
	local state=$(nmcli connection show Vpn | rg -i state.*activated)
	[ "${state}" != "" ] && printf on || printf off
}

# Toggle vpn.
function vpn() {
	if [[ "$(_vpn)" == "on" ]]; then
		notify_long
		nmcli connection down Vpn
	else
		notify_short
		nmcli connection up Vpn
	fi
}

function _vpn() {
	local state=$(nmcli connection show Vpn | rg -i state.*activated)
	[ "${state}" != "" ] && printf on || printf off
}

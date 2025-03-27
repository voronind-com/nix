export VPN_NAME=fsight

# Toggle vpn.
function vpn() {
	if [[ "$(_vpn)" == "on" ]]; then
		notify_long
		nmcli connection down ${VPN_NAME}
	else
		notify_short
		nmcli connection up ${VPN_NAME}
	fi
}

function _vpn() {
	local state=$(nmcli connection show ${VPN_NAME} | rg -i state.*activated)
	[ "${state}" != "" ] && printf on || printf off
}

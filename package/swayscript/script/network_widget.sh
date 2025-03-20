# Waybar output.
function networkwidget() {
	local IFS=$'\n'
	local internet=$(nmcli networking connectivity check)
	local _connections=($(nmcli connection show --active))
	local _ethernets=($(printf "%s\n" ${_connections[@]} | rg ethernet | sed "s/  .*//"))
	local _vpns=($(printf "%s\n" ${_connections[@]} | rg vpn | sed "s/  .*//"))
	local _wifis=($(printf "%s\n" ${_connections[@]} | rg wifi | sed "s/  .*//"))
	local _bts_raw=($(timeout 2 bluetoothctl devices Connected)) # HACK: Sometimes it hangs, thus a timeout.
	local _bts=()
	local _bt_lowest=100
	local icon="?"
	local class=""

	local ic_btlow="󰂃"
	local ic_disabled="󰲛"
	local ic_none="󰀝"
	local ic_vpn="󰌾"
	local ic_bt="󰂯"
	local ic_wifi="󰖩"
	local ic_ethernet="󰈁"

	for bt in ${_bts_raw[@]}; do
		local name=$(printf "%s" ${bt} | cut -d\  -f3)
		local mac=$(printf "%s" ${bt} | cut -d\  -f2 | sed -e "s/:/_/g")
		local bat=$(dbus-send --print-reply=literal --system --dest=org.bluez /org/bluez/hci0/dev_${mac} org.freedesktop.DBus.Properties.Get string:"org.bluez.Battery1" string:"Percentage" 2>/dev/null | cut -d\  -f12)
		local btinfo="${name}"

		if [[ ${bat} != "" ]]; then
			btinfo+=" ${bat}%"
			[[ ${bat} -lt ${_bt_lowest} ]] && _bt_lowest=${bat}
		fi

		_bts+=("${btinfo}")
	done

	if [ "${_bt_lowest}" -lt 21 ]; then
		class="btlow"
		icon="${ic_btlow}"
	elif ! command -v nmcli &>/dev/null; then
		class="disabled"
		icon="${ic_disabled}"
	elif [ "${internet}" != "full" ]; then
		class="none"
		icon="${ic_none}"
	elif [ "${_vpns}" != "" ]; then
		class="vpn"
		icon="${ic_vpn}"
	elif [ "${_bts}" != "" ]; then
		class="bt"
		icon="${ic_bt}"
	elif [ "${_wifis}" != "" ]; then
		class="wifi"
		icon="${ic_wifi}"
	elif [ "${_ethernets}" != "" ]; then
		class="ethernet"
		icon="${ic_ethernet}"
	fi

	for net in ${_vpns[@]}; do
		networks+="${ic_vpn} ${net}\\n"
	done
	for net in ${_ethernets[@]}; do
		networks+="${ic_ethernet} ${net}\\n"
	done
	for net in ${_wifis[@]}; do
		networks+="${ic_wifi} ${net}\\n"
	done
	for bt in ${_bts[@]}; do
		networks+="${ic_bt} ${bt}\\n"
	done

	networks=${networks%\\n}
	printf "%s" "{\"text\": \"${icon}\", \"tooltip\": \"${networks}\", \"class\": \"${class}\"}\n"
}

# Toggle network.
function network() {
	notify_short
	local state=$(nmcli networking)
	if [[ ${state} == "enabled" ]]; then
		nmcli networking off
	else
		nmcli networking on
	fi
}

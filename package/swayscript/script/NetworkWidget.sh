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
	local icon="󰖩"
	local class=""

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

	if [[ ${_bts} != "" ]]; then
		class="bt"
		icon="󱛃"
	fi

	if [[ ${_vpns} != "" ]]; then
		class="vpn"
		icon="󱚿"
	fi

	if ! $(command -v nmcli); then
		class="disabled"
		icon="󱚼"
	elif [[ ${internet} != "full" ]]; then
		class="issue"
		icon="󱚵"
	fi

	if [[ ${_bt_lowest} -lt 21 ]]; then
		class="btlow"
	fi

	for net in ${_vpns[@]}; do
		networks+=" ${net}\\n"
	done

	for net in ${_ethernets[@]}; do
		networks+=" ${net}\\n"
	done

	for net in ${_wifis[@]}; do
		networks+="󰖩 ${net}\\n"
	done

	for bt in ${_bts[@]}; do
		networks+="󰂯 ${bt}\\n"
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

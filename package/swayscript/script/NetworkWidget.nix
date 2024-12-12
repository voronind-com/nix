{ ... }: {
	text = ''
		# Waybar output.
		function networkwidget() {
			local IFS=$'\n'
			local internet=$(nmcli networking connectivity check)
			local _ethernets=($(nmcli connection show --active | rg ethernet | cut -f1 -d\ ))
			local _vpns=($(nmcli connection show --active | rg vpn | cut -f1 -d\ ))
			local _wifis=($(nmcli connection show --active | rg wifi | cut -f1 -d\ ))
			local _bts=($(bluetoothctl devices Connected | cut -d\  -f3))
			local icon="󰖩"
			local class=""

			if [[ "''${_bts}" != "" ]]; then
				icon="󱛃"
			fi

			if [[ "''${_vpns}" != "" ]]; then
				class="vpn"
				icon="󱚿"
			fi

			if [[ "''${internet}" != "full" ]]; then
				class="issue"
				icon="󱚵"
			fi

			for net in ''${_vpns[@]}; do
				[[ "''${networks}" = "" ]] || networks+="\\\n"
				networks+=" ''${net}"
			done

			for net in ''${_ethernets[@]}; do
				[[ "''${networks}" = "" ]] || networks+="\\\n"
				networks+=" ''${net}"
			done

			for net in ''${_wifis[@]}; do
				[[ "''${networks}" = "" ]] || networks+="\\\n"
				networks+="󰖩 ''${net}"
			done

			for bt in ''${_bts[@]}; do
				[[ "''${networks}" = "" ]] || networks+="\\\n"
				networks+="󰂯 ''${bt}"
			done

			printf "{\"text\": \"''${icon}\", \"tooltip\": \"''${networks[@]}\", \"class\": \"''${class}\"}\n"
		}

		# Toggle network.
		function network() {
			notify_short
			local state=$(nmcli networking)
			if [[ "''${state}" = "enabled" ]]; then
				nmcli networking off
			else
				nmcli networking on
			fi
		}
	'';
}

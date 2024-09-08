{ ... }: {
	text = ''
		# Toggle vpn.
		function vpntoggle() {
			if [[ "$(_vpnstate)" = "on" ]]; then
				nmcli connection down vpn
			else
				nmcli connection up vpn
			fi
		}

		function _vpnstate() {
			local state=$(nmcli connection show vpn | rg -i state.*activated)
			[ "''${state}" != "" ] && printf on || printf off
		}
	'';
}

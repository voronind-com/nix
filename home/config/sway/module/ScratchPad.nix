{ ... }: {
	text = ''
		# Sway has a "scratchpad", which is a bag of holding for windows.
		# You can send windows there and get them back later.
		# NOTE: Get id with `swaymsg -t get_tree`.

		# Move the currently focused window to the scratchpad
		bindsym $mod+shift+C move scratchpad

		# Show the next scratchpad window or hide the focused scratchpad window.
		# If there are multiple scratchpad windows, this command cycles through them.
		bindsym $mod+c scratchpad show

		# Fix for a goddamn Firefox WebRTC indicator.
		for_window [app_id="firefox" title="Firefox — Sharing Indicator"] {
			kill
		}

		# NetworkManager.
		for_window [app_id="nm-connection-editor"] {
			move scratchpad
			scratchpad show
		}

		# Bluetooth.
		for_window [app_id=".blueman-manager-wrapped"] {
			move scratchpad
			scratchpad show
		}

		# Sound.
		for_window [app_id="pwvucontrol"] {
			move scratchpad
			scratchpad show
		}

		# Android emulator controls.
		for_window [title="Emulator" window_type="utility"] {
			move scratchpad
		}

		# Calculator.
		for_window [app_id="org.gnome.Calculator"] {
			move scratchpad
			scratchpad show
		}
	'';
}

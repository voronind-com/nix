{ ... }: {
	text = ''
		# Reload.
		function reload() {
			re() {
				swaymsg reload
				pkill waybar
				swaymsg exec waybar
				tmux source-file ~/.config/tmux/tmux.conf
			}

			_sway_iterate_sockets re
		}
	'';
}

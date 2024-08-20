{ ... }: {
	text = ''
		# Reload.
		function reload() {
			re() {
				# Sway.
				swaymsg reload

				# Waybar.
				pkill waybar
				swaymsg exec waybar

				# Tmux.
				tmux source-file ~/.config/tmux/tmux.conf

				# Bash.
				pkill -SIGUSR1 bash
			}

			_sway_iterate_sockets re
		}
	'';
}

# Reload.
function reload() {
	# notify_long
	re() {
		# Sway.
		swaymsg reload
		swaymsg seat seat0 xcursor_theme $XCURSOR_THEME $XCURSOR_SIZE
		pkill mpvpaper && wallpaper-video

		# Waybar.
		pkill waybar
		swaymsg exec waybar

		# Tmux.
		tmux source-file ~/.config/tmux/tmux.conf

		# Bash.
		pkill -SIGUSR1 bash

		# Notifications.
		makoctl reload

		# Reset displays.
		displayreset
	}

	_sway_iterate_sockets re
}

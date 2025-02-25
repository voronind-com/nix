# Toggle video wallpaper.
function wallpaper_video() {
	re() {
		pkill mpvpaper && notify_long || {
			notify_short
			wallpaper-video
		}
	}

	_sway_iterate_sockets re
}

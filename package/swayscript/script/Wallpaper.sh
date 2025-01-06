# Toggle video wallpaper.
function wallpaper_video() {
	notify_short
	re() {
		pkill mpvpaper || wallpaper-video
	}

	_sway_iterate_sockets re
}

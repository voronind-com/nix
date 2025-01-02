# Toggle video wallpaper.
function wallpaper_video() {
	notify_short
	pkill mpvpaper || wallpaper-video
}

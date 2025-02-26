# Show only physical drives info.
function pdf() {
	df --si | sed -e '1p' -e '/^\/dev\//!d'
}

# Show total size in SI.
# Current dir by default.
# Usage: tdu [DIRS]
function tdu() {
	du -sh --si "${@}"
}

# Show apparent size in SI.
# Current dir by default.
# Usage: tdua [DIRS]
function tdua() {
	du -sh --si --apparent-size "${@}"
}

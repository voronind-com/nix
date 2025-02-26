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

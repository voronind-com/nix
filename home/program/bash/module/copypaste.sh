# Copy stdin to system clipboard. *Example:* `echo hi \| copy`.
function copy() {
	wl-copy
}

# Paste system clipboard to stdout. *Example:* `paste > file.txt`.
function paste() {
	wl-paste
}

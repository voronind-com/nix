function poweroff() {
	notify_short
	systemctl poweroff -i
}

function reboot() {
	notify_short
	systemctl reboot -i
}

function suspend() {
	notify_short
	systemctl suspend -i
}

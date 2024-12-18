# Send Telegram notification.
# Usage: notify <MESSAGE>
function notify() {
	curl -X POST -H 'Content-Type: Application/json' -d "@tgdata@" @tgbot@ &>/dev/null
}

# Send silent Telegram notification.
# Usage: notify_silent <MESSAGE>
function notify_silent() {
	curl -X POST -H 'Content-Type: Application/json' -d "@tgdatasilent@" @tgbot@ &>/dev/null
}

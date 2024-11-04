{ secret, ... }: {
	text = ''
		# Send Telegram notification.
		# Usage: notify <MESSAGE>
		function notify() {
			curl -X POST -H 'Content-Type: Application/json' -d "${secret.tg.dt "false"}" ${secret.tg.bt} &> /dev/null
		}

		# Send silent Telegram notification.
		# Usage: notify_silent <MESSAGE>
		function notify_silent() {
			curl -X POST -H 'Content-Type: Application/json' -d "${secret.tg.dt "true"}" ${secret.tg.bt} &> /dev/null
		}
	'';
}

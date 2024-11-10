{ ... }: {
	text = ''
		# Kill all ssh sockets.
		function sshka() {
			rm ~/.ssh/*.socket
		}
	'';
}

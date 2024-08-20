{ ... }: {
	text = ''
		function reload() {
			source ~/.bashrc
		}
		trap reload USR1
	'';
}

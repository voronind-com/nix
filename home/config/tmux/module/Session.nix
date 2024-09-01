{ ... }: {
	text = ''
		bind -n M-z detach-client
		bind -n M-Z detach-client -a

		bind -n M-( switch-client -p
		bind -n M-) switch-client -n
		bind -n M-g choose-session -Z

		set -g window-size smallest
	'';
}

{ ... }: {
	text = ''
		unbind-key C-b
		bind -n M-r source-file ~/.config/tmux/tmux.conf
	'';
}

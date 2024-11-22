{ ... }: {
	text = ''
		setw -g mode-keys vi
		bind -n M-v copy-mode
		bind -n M-p choose-buffer;
		bind -T copy-mode-vi v send      -X begin-selection
		bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
	'';
}

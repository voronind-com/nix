{ config, ... }: let
	mod = "M";

	fg        = config.module.style.color.bg.dark;
	selection = config.module.style.color.selection;
in {
	text = ''
		setw -g mode-keys vi
		bind -n ${mod}-v copy-mode
		bind -n ${mod}-V choose-buffer;
		bind -T copy-mode-vi v send      -X begin-selection
		bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

		set -g mode-style "fg=#${fg} bg=#${selection} bold"
	'';
}

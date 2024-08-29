{ config, ... }: let
	mod = "M";

	accent = config.style.color.accent;
	bg     = config.style.color.bg.regular;
	# fg     = style.color.fg.light;

	stepVertical   = 1;
	stepHorizontal = 1;
in {
	text = ''
		bind -n ${mod}-\\ split-window  -h -c "#{pane_current_path}"
		bind -n ${mod}--  split-window  -v -c "#{pane_current_path}"
		bind -n ${mod}-=  select-layout tiled
		bind -n ${mod}-+  select-layout even-vertical
		bind -n ${mod}-k  resize-pane -U ${toString stepVertical}
		bind -n ${mod}-j  resize-pane -D ${toString stepVertical}
		bind -n ${mod}-h  resize-pane -L ${toString stepHorizontal}
		bind -n ${mod}-l  resize-pane -R ${toString stepHorizontal}
		bind -n ${mod}-A  swap-pane   -U
		bind -n ${mod}-D  swap-pane   -D
		unbind '"'
		unbind %

		bind -n ${mod}-a select-pane -L
		bind -n ${mod}-d select-pane -R
		bind -n ${mod}-w select-pane -U
		bind -n ${mod}-s select-pane -D

		bind -n ${mod}-c kill-pane
		bind -n ${mod}-C kill-pane -a

		set -g pane-border-style        "fg=#${bg}"
		set -g pane-active-border-style "fg=#${accent}"
	'';
}

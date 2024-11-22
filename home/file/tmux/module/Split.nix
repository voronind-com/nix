{ ... }: let
	stepHorizontal = 1;
	stepVertical   = 1;
in {
	text = ''
		bind -n M-\\ split-window  -h -c "#{pane_current_path}"
		bind -n M--  split-window  -v -c "#{pane_current_path}"
		bind -n M-=  select-layout tiled
		bind -n M-_  select-layout even-vertical
		bind -n M-|  select-layout even-horizontal
		bind -n M-+  select-layout main-vertical
		bind -n M-k  resize-pane -U ${toString stepVertical}
		bind -n M-j  resize-pane -D ${toString stepVertical}
		bind -n M-h  resize-pane -L ${toString stepHorizontal}
		bind -n M-l  resize-pane -R ${toString stepHorizontal}
		bind -n M-A  swap-pane   -U
		bind -n M-W  swap-pane   -U
		bind -n M-D  swap-pane   -D
		bind -n M-S  swap-pane   -D
		unbind '"'
		unbind %

		bind -n M-a select-pane -L
		bind -n M-d select-pane -R
		bind -n M-w select-pane -U
		bind -n M-s select-pane -D

		bind -n M-c kill-pane
		bind -n M-C kill-pane -a
	'';
}

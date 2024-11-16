{ ... }: let
	step_music  = 10;
	step_volume = 5;
in {
	text = ''
		bindsym --to-code XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +${toString step_volume}%'
		bindsym --to-code XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -${toString step_volume}%'
		bindsym --to-code XF86AudioMute        exec 'pactl set-sink-mute   @DEFAULT_SINK@ toggle'
		bindsym --to-code XF86AudioMicMute     exec 'pactl set-source-mute @DEFAULT_SOURCE@ toggle'

		bindsym --to-code XF86AudioPlay  exec 'playerctl play-pause'
		bindsym --to-code XF86AudioPause exec 'playerctl pause'
		bindsym --to-code XF86AudioStop  exec 'playerctl stop'
		bindsym --to-code XF86AudioNext  exec 'playerctl next'
		bindsym --to-code XF86AudioPrev  exec 'playerctl previous'
		bindsym --to-code XF86Forward    exec 'playerctl position ${toString step_music}+'
		bindsym --to-code XF86Back       exec 'playerctl position ${toString step_music}-'
		bindsym --to-code XF86Eject      exec 'swayscript sound_output_cycle'
	'';
}

{ config, ... }: let
	step = 5;
in {
	text = ''
		bindsym XF86MonBrightnessDown exec light -U ${toString step}
		bindsym XF86MonBrightnessUp   exec light -A ${toString step}
	'';
}

{ config, ... }: let
	lock = "swaylock -f -F -c 000000 -k --font \"${config.style.font.serif.name}\" --font-size ${toString config.style.font.size.desktop}";
in {
	text = ''
		bindsym $mod+z exec '_twice 1 ${lock}'
		bindsym $mod+Shift+Z exec _twice 1 bash -c '${lock}; systemctl suspend -i'
	'';
}
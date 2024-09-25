{ config, ... }: let
	fontName = config.style.font.sansSerif.name;
	# fontSize = toString config.style.font.size.desktop;
in {
	text = ''
		font "${fontName} Medium 0.01"
	'';
}

{
	config,
	...
}: let
	fontName = config.module.style.font.sansSerif.name;
in {
	text = ''
		font "${fontName} Medium 0.01"
	'';
}

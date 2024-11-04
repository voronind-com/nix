{
	config,
	pkgs,
	...
}: {
	font = pkgs.runCommandNoCC "font" { } ''
		cp ${pkgs.nerdfonts.override { fonts = [ "Terminus" ]; }}/share/fonts/truetype/NerdFonts/TerminessNerdFontMono-Regular.ttf $out
	'';

	colors = with config.module.style.color; {
		background = "#${bg.dark}";
		cursor     = "#${fg.light}";
		foreground = "#${fg.light}";
	};
}

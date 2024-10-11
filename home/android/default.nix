{ pkgs, config, ... }:
{
  font = pkgs.runCommandNoCC "font" { } ''
    cp ${
      pkgs.nerdfonts.override { fonts = [ "Terminus" ]; }
    }/share/fonts/truetype/NerdFonts/TerminessNerdFontMono-Regular.ttf $out
  '';

  colors = ''
    background=#${config.style.color.bg.dark}
    foreground=#${config.style.color.fg.light}
  '';
}

{ config, ... }:
let
  fontName = config.style.font.sansSerif.name;
in
# fontSize = toString config.style.font.size.desktop;
{
  text = ''
    font "${fontName} Medium 0.01"
  '';
}

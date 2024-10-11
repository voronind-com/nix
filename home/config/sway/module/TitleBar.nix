{ config, ... }:
let
  borderSize = toString config.style.window.border;
in
{
  text = ''
    # Disable title bar.
    default_border pixel ${borderSize}
    default_floating_border pixel ${borderSize}
    titlebar_padding 1
    titlebar_border_thickness 0
  '';
}

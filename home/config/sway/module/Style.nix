{ config, ... }:
let
  alpha = config.style.opacity.hex;
  accent = config.style.color.accent + alpha;
  bg = config.style.color.bg.dark + alpha;
  border = config.style.color.border + alpha;
  fg = config.style.color.fg.light;
in
{
  text = ''
    output * bg ${config.module.wallpaper.path} fill
    client.focused          "#${accent}" "#${bg}" "#${fg}" "#${accent}" "#${accent}"
    client.focused_inactive "#${border}" "#${bg}" "#${fg}" "#${border}" "#${border}"
    client.unfocused        "#${border}" "#${bg}" "#${fg}" "#${border}" "#${border}"
    client.urgent           "#${border}" "#${bg}" "#${fg}" "#${border}" "#${border}"
    client.placeholder      "#${bg}"     "#${bg}" "#${fg}" "#${bg}"     "#${bg}"
  '';
}

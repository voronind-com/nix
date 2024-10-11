{ config, ... }:
{
  text = ''
    * {
      font-family: "${config.style.font.serif.name}", "Terminess Nerd Font Propo";
      font-size: ${toString config.style.font.size.desktop}px;
      color: #${config.style.color.fg.light};
    }
  '';
}

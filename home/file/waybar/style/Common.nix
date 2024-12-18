{ config, ... }:
{
  text = ''
    * {
      font-family: "${config.module.style.font.serif.name}", "Terminess Nerd Font Propo";
      font-size: ${toString config.module.style.font.size.desktop}px;
      color: #${config.module.style.color.fg.light};
    }
  '';
}

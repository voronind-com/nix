{ config, ... }:
{
  text = ''
    window#waybar {
      background-color: rgba(${config.module.style.color.bgR},${config.module.style.color.bgG},${config.module.style.color.bgB},${toString config.module.style.opacity.desktop});
      border: ${toString config.module.style.window.border}px solid rgba(${config.module.style.color.borderR},${config.module.style.color.borderG},${config.module.style.color.borderB},${toString config.module.style.opacity.desktop});
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: ${toString config.module.style.window.border}px;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: ${toString config.module.style.window.border}px;
    }
  '';
}

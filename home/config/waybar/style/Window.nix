{ config, ... }:
{
  text = ''
    window#waybar {
      background-color: rgba(${config.style.color.bg-r},${config.style.color.bg-g},${config.style.color.bg-b},${toString config.style.opacity.desktop});
      border: ${toString config.style.window.border}px solid rgba(${config.style.color.border-r},${config.style.color.border-g},${config.style.color.border-b},${toString config.style.opacity.desktop});
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: ${toString config.style.window.border}px;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: ${toString config.style.window.border}px;
    }
  '';
}

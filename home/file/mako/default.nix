{
  __findFile,
  config,
  pkgs,
  ...
}@args:
let
  alpha = config.module.style.opacity.hex;
  color = config.module.style.color;
  max = 1;
  swayscript = pkgs.callPackage <package/swayscript> args;
  timeout = config.module.style.timeout.popup;
in
{
  file = (pkgs.formats.iniWithGlobalSection { }).generate "mako-config" {
    globalSection = {
      anchor = "top-center";
      background-color = "#${color.highlight}${alpha}";
      border-color = "#${color.border}${alpha}";
      default-timeout = timeout;
      font = "${config.module.style.font.serif.name} ${toString config.module.style.font.size.popup}";
      height = 120;
      icons = 0;
      margin = 32;
      max-history = max;
      max-visible = max;
      on-notify = "exec ${swayscript}/bin/swayscript notify";
      text-color = "#${config.module.style.color.bg.dark}";
      width = 480;
    };
    sections = {
      "mode=dnd" = {
        invisible = 1;
        on-notify = "exec ${pkgs.coreutils}/bin/true";
      };
    };
  };
}

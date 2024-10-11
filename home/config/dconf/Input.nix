{ lib, config, ... }:
{
  "org/gnome/desktop/input-sources" = with lib.gvariant; {
    current = mkUint32 0;
    mru-sources = [
      (mkTuple [
        "xkb"
        "us"
      ])
      (mkTuple [
        "xkb"
        "ru"
      ])
    ];
    per-window = false;
    show-all-sources = true;
    sources = [
      (mkTuple [
        "xkb"
        "us"
      ])
      (mkTuple [
        "xkb"
        "ru"
      ])
    ];
    xkb-options = [ config.setting.keyboard.options ];
  };

  "org/gnome/desktop/peripherals/mouse" = {
    accel-profile = "flat";
    natural-scroll = true;
    speed = "0.0";
  };

  "org/gnome/desktop/peripherals/touchpad" = {
    tap-to-click = true;
    two-finger-scrolling-enabled = true;
  };
}

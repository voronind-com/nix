{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.keyd;
in
{
  options = {
    module.keyd = {
      enable = mkEnableOption "Keyboard remaps.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ keyd ];

    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          # NOTE: Use `wev` to find key names.
          main = {
            backspace = "delete"; # Delete key on backspace.
            capslock = "overload(control, esc)"; # Ctrl/esc combo.
            compose = "layer(layer_number)"; # Number input layer.
            esc = "print"; # System controls.
            leftcontrol = "overload(layer_alternative, leftcontrol)"; # Alternative layer for home, end etc.
            rightcontrol = "layer(layer_control)"; # Media and other controls.
            rightshift = "backspace"; # Backspace.
          };

          # Alternative navigation.
          layer_alternative = {
            w = "pageup";
            a = "home";
            s = "pagedown";
            d = "end";
            x = "cut";
            c = "copy";
            v = "paste";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            esc = "esc";
            rightcontrol = "leftcontrol";
            capslock = "capslock";
            # space = "macro2(1, 100, macro(space))"; # NOTE: Possible bhop example. Use in per-application, not here.
          };

          # Media controls.
          layer_control = {
            space = "playpause";
            a = "back";
            c = "ejectcd";
            d = "forward";
            e = "nextsong";
            q = "previoussong";
            s = "volumedown";
            v = "micmute";
            w = "volumeup";
            x = "stopcd";
            z = "mute";
          };

          # Number inputs.
          layer_number = {
            q = "7";
            w = "8";
            e = "9";
            a = "4";
            s = "5";
            d = "6";
            z = "1";
            x = "2";
            c = "3";
            space = "0";
            "1" = "kpequal";
            "2" = "kpslash";
            "3" = "kpasterisk";
            "4" = "kpminus";
            f = "kpenter";
            r = "kpplus";
            v = "kpcomma";
            shift = "backspace";
          };
        };
      };
    };

    # HACK: Workaround for https://github.com/NixOS/nixpkgs/issues/290161
    users.groups.keyd = { };
    systemd.services.keyd.serviceConfig.CapabilityBoundingSet = [ "CAP_SETGID" ];

    # Debug toggle just in case I need it again.
    # systemd.services.keyd.environment.KEYD_DEBUG = "1";
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.keyd;
in
{
  config = lib.mkIf cfg.enable {
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
            delete = "backslash";
            esc = "print"; # System controls.
            left = "layer(layer_number)"; # Number input layer.
            leftcontrol = "overload(layer_alternative, leftcontrol)"; # Alternative layer for home, end etc.
            right = "compose";
            rightcontrol = "layer(layer_control)"; # Media and other controls.
            rightshift = "backspace"; # Backspace.
          };

          # Alternative navigation.
          layer_alternative = {
            a = "home";
            c = "copy";
            d = "end";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            s = "pagedown";
            v = "paste";
            w = "pageup";
            x = "cut";
            esc = "esc";
            rightcontrol = "leftcontrol";
            capslock = "capslock";
            "1" = "f1";
            "2" = "f2";
            "3" = "f3";
            "4" = "f4";
            "5" = "f5";
            "6" = "f6";
            "7" = "f7";
            "8" = "f8";
            "9" = "f9";
            "0" = "f10";
            minus = "f11";
            equal = "f12";
          };

          # Media controls.
          layer_control = {
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
            space = "playpause";
          };

          # Number inputs.
          layer_number = {
            "1" = "kpequal";
            "2" = "kpslash";
            "3" = "kpasterisk";
            "4" = "kpminus";
            a = "4";
            c = "3";
            d = "6";
            e = "9";
            f = "kpenter";
            q = "7";
            r = "kpplus";
            s = "5";
            v = "kpcomma";
            w = "8";
            x = "2";
            z = "1";
            shift = "backspace";
            space = "0";
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

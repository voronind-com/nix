{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.keyd;
  timeout = 150;
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
            # down = "micmute";
            # right = "compose";
            # rightcontrol = "overload(layer_control, mute)"; # Media and other controls.
            # up = "mute";
            backspace = "delete"; # Delete key on backspace.
            capslock = "overload(control, esc)"; # Ctrl/esc combo.
            compose = "layer(layer_number)"; # Number input layer.
            delete = "backslash";
            esc = "timeout(grave, ${toString timeout}, print)"; # System controls.
            left = "compose"; # Number input layer.
            leftcontrol = "overload(layer_alternative, leftcontrol)"; # Alternative layer for home, end etc.
            print = "compose";
            rightcontrol = "timeout(micmute, ${toString timeout}, layer(layer_control))"; # Media and other controls.
            rightshift = "backspace"; # Backspace.
          };

          # Alternative navigation.
          layer_alternative = {
            "0" = "f10";
            "1" = "f1";
            "2" = "f2";
            "3" = "f3";
            "4" = "f4";
            "5" = "f5";
            "6" = "f6";
            "7" = "f7";
            "8" = "f8";
            "9" = "f9";
            a = "home";
            backspace = "backspace";
            c = "copy";
            capslock = "capslock";
            compose = "compose";
            d = "end";
            delete = "delete";
            down = "down";
            equal = "f12";
            esc = "esc";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            left = "left";
            minus = "f11";
            print = "print";
            right = "right";
            rightcontrol = "leftcontrol";
            rightshift = "rightshift";
            s = "pagedown";
            up = "up";
            v = "paste";
            w = "pageup";
            x = "cut";
            # z = "micmute";
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

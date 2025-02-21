{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.keyd;
  mkAllLetterKeysSet =
    mkValue:
    "abcdefghijklmnopqrstuvwxyz"
    |> lib.strings.stringToCharacters
    |> map (key: {
      name = key;
      value = mkValue key;
    })
    |> lib.listToAttrs;
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
            compose = "layer(layer_alternative)";
            delete = "backslash";
            esc = "overload(layer_print, grave)"; # System controls.
            leftcontrol = "overload(layer_alternative, leftcontrol)"; # Alternative layer for home, end etc.
            rightcontrol = "layer(layer_number)"; # Media and other controls.
            rightshift = "backspace"; # Backspace.
          };

          # Alternative navigation.
          layer_alternative = {
            # Fx keys.
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
            equal = "f12";
            minus = "f11";

            # Legacy navigation.
            a = "home";
            d = "end";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            n = "pagedown";
            p = "pageup";

            # Media controls.
            c = "mute";
            comma = "back";
            dot = "forward";
            e = "nextsong";
            q = "previoussong";
            r = "media"; # Toggle audio output.
            s = "volumedown";
            space = "playpause";
            t = "record"; # Toggle audio input.
            v = "micmute";
            w = "volumeup";
            x = "stopcd";

            # Reset keys.
            backspace = "backspace";
            capslock = "capslock";
            compose = "compose";
            delete = "delete";
            esc = "esc";
            rightcontrol = "leftcontrol";
            rightshift = "delete";
          };

          # NOTE: Vacant compose key layer.
          # layer_compose = { };

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

          layer_print = mkAllLetterKeysSet (key: "macro(print+${key})");
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

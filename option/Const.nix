{ lib, ... }:
{
  options.const = {
    droidStateVersion = lib.mkOption {
      default = "24.05";
      type = lib.types.str;
    };
    stateVersion = lib.mkOption {
      default = "24.11";
      type = lib.types.str;
    };
    timeZone = lib.mkOption {
      default = "Europe/Moscow";
      type = lib.types.str;
    };
    url = lib.mkOption {
      default = "https://git.voronind.com/voronind/nix.git";
      type = lib.types.str;
    };
    host = lib.mkOption {
      default = { };
      type = lib.types.attrs;
    };
  };
}

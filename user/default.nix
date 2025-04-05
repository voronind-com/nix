{ config, lib, ... }:
let
  primary = config.user.user |> lib.filterAttrs (n: v: v.primary) |> lib.attrsToList;
in
{
  options.user = {
    primary = lib.mkOption {
      default = (lib.elemAt primary 0).name or "root";
      type = lib.types.str;
    };
  };
}

{ config, lib, ... }:
let
  primary = config.user.user |> lib.filterAttrs (n: v: v.primary or false) |> lib.attrsToList;
in
{
  options.user = {
    primary = lib.mkOption {
      default = if lib.length primary > 0 then (lib.elemAt primary 0).name else "root";
      type = lib.types.str;
    };
  };

  config = {
    assertions = [
      {
        assertion = lib.length primary <= 1;
        message = "Only one user can be primary. Current primary users: ${
          primary |> map (u: u.name) |> toString
        }";
      }
    ];
  };
}

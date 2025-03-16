# Display configuration.
{ lib, config, ... }:
let
  cfg = config.module.display;
in
{
  # REF: https://www.kernel.org/doc/Documentation/fb/fbcon.txt
  # REF: https://patchwork.kernel.org/project/dri-devel/patch/20191110154101.26486-10-hdegoede@redhat.com/#22993841
  config = lib.mkMerge [
    # NOTE: `tty` name is special.
    (lib.mkIf (cfg.rotate != null) {
      boot.kernelParams = lib.mapAttrsToList (
        name: rotate:
        let
          # ISSUE: https://github.com/swaywm/sway/issues/8478
          hint =
            if rotate == 90 then
              "left_side_up"
            else if rotate == 180 then
              "upside_down"
            else if rotate == 270 then
              "right_side_up"
            else
              "normal";

          value =
            if rotate == 90 then
              1
            else if rotate == 180 then
              2
            else if rotate == 270 then
              3
            else
              0;

          command =
            if name == "tty" then
              "fbcon=rotate:${toString value}"
            else
              "video=${name}:rotate=${toString rotate}";
        in
        # "video=${name}:panel_orientation=${hint}";
        # "video=${name}:rotate=${toString rotate},panel_orientation=${hint}";
        command
      ) cfg.rotate;

      module.sway.extraConfig = lib.mapAttrsToList (
        name: rotate: "output ${name} transform ${toString rotate}"
      ) cfg.rotate;
    })
  ];
}

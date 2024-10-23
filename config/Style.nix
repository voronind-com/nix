{
  lib,
  config,
  pkgs,
  __findFile,
  ...
}:
with lib;
let
  cfg = config.style;

  mkTypeOption = default: type: mkOption { inherit default type; };
  mkStrOption = default: mkTypeOption default types.str;
  mkIntOption = default: mkTypeOption default types.int;
  mkFloatOption = default: mkTypeOption default types.float;
  mkPkgOption = default: mkTypeOption default types.package;
in
{
  options.style = {
    color = {
      bg = {
        dark = mkStrOption config.lib.stylix.colors.base00;
        light = mkStrOption config.lib.stylix.colors.base07;
        regular = mkStrOption config.lib.stylix.colors.base01;
      };
      fg = {
        dark = mkStrOption config.lib.stylix.colors.base04;
        light = mkStrOption config.lib.stylix.colors.base06;
        regular = mkStrOption config.lib.stylix.colors.base05;
      };
      accent = mkStrOption config.lib.stylix.colors.base0A;
      heading = mkStrOption config.lib.stylix.colors.base0D;
      hl = mkStrOption config.lib.stylix.colors.base03;
      keyword = mkStrOption config.lib.stylix.colors.base0E;
      link = mkStrOption config.lib.stylix.colors.base09;
      misc = mkStrOption config.lib.stylix.colors.base0F;
      negative = mkStrOption config.lib.stylix.colors.base08;
      neutral = mkStrOption config.lib.stylix.colors.base0C;
      positive = mkStrOption config.lib.stylix.colors.base0B;
      selection = mkStrOption config.lib.stylix.colors.base02;
      transparent = mkStrOption "ffffff00";

      accent-b = mkStrOption config.lib.stylix.colors.base0A-rgb-b;
      accent-g = mkStrOption config.lib.stylix.colors.base0A-rgb-g;
      accent-r = mkStrOption config.lib.stylix.colors.base0A-rgb-r;

      negative-b = mkStrOption config.lib.stylix.colors.base08-rgb-b;
      negative-g = mkStrOption config.lib.stylix.colors.base08-rgb-g;
      negative-r = mkStrOption config.lib.stylix.colors.base08-rgb-r;

      neutral-b = mkStrOption config.lib.stylix.colors.base0C-rgb-b;
      neutral-g = mkStrOption config.lib.stylix.colors.base0C-rgb-g;
      neutral-r = mkStrOption config.lib.stylix.colors.base0C-rgb-r;

      positive-b = mkStrOption config.lib.stylix.colors.base0B-rgb-b;
      positive-g = mkStrOption config.lib.stylix.colors.base0B-rgb-g;
      positive-r = mkStrOption config.lib.stylix.colors.base0B-rgb-r;

      bg-b = mkStrOption config.lib.stylix.colors.base00-rgb-b;
      bg-g = mkStrOption config.lib.stylix.colors.base00-rgb-g;
      bg-r = mkStrOption config.lib.stylix.colors.base00-rgb-r;

      fg-b = mkStrOption config.lib.stylix.colors.base06-rgb-b;
      fg-g = mkStrOption config.lib.stylix.colors.base06-rgb-g;
      fg-r = mkStrOption config.lib.stylix.colors.base06-rgb-r;

      border = mkStrOption config.lib.stylix.colors.base01;
      border-b = mkStrOption config.lib.stylix.colors.base01-rgb-b;
      border-g = mkStrOption config.lib.stylix.colors.base01-rgb-g;
      border-r = mkStrOption config.lib.stylix.colors.base01-rgb-r;
    };

    font = {
      size = {
        application = mkIntOption 12;
        terminal = mkIntOption 14;
        popup = mkIntOption 12;
        desktop = mkIntOption 14;
      };
      serif = {
        package = mkPkgOption (pkgs.callPackage <package/applefont> { });
        name = mkStrOption "SF Pro Display";
      };
      sansSerif = {
        package = mkPkgOption (pkgs.callPackage <package/applefont> { });
        name = mkStrOption "SF Pro Display";
      };
      monospace = {
        package = mkPkgOption (pkgs.nerdfonts.override { fonts = [ "Terminus" ]; });
        name = mkStrOption "Terminess Nerd Font Mono";
      };
      emoji = {
        package = mkPkgOption pkgs.noto-fonts-emoji;
        name = mkStrOption "Noto Color Emoji";
      };
    };

    opacity = {
      application = mkFloatOption 0.85;
      desktop = mkFloatOption 0.85;
      popup = mkFloatOption 0.85;
      terminal = mkFloatOption 0.85;
      hex = mkStrOption "D9";
    };

    # cursor = {
    #   name = mkStrOption "Adwaita";
    #   package = mkPkgOption pkgs.adwaita-icon-theme;
    #   size = mkIntOption 14;
    # };

    cursor = {
      name = mkStrOption "phinger-cursors-dark";
      package = mkPkgOption pkgs.phinger-cursors;
      size = mkIntOption 24;
    };

    window = {
      gap = mkIntOption 8;
      border = mkIntOption 4;
    };
  };
}

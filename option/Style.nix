# Styling like colors, fonts, cursor etc.
{
  __findFile,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.style;
  stylix = config.lib.stylix or config.home-manager.config.lib.stylix;

  mkTypeOption = default: type: lib.mkOption { inherit default type; };
  mkFloatOption = default: mkTypeOption default lib.types.float;
  mkIntOption = default: mkTypeOption default lib.types.int;
  mkPkgOption = default: mkTypeOption default lib.types.package;
  mkStrOption = default: mkTypeOption default lib.types.str;
in
{
  options.module.style = {
    color = {
      accent = mkStrOption stylix.colors.base0A;
      heading = mkStrOption stylix.colors.base0D;
      highlight = mkStrOption stylix.colors.base03;
      keyword = mkStrOption stylix.colors.base0E;
      link = mkStrOption stylix.colors.base09;
      misc = mkStrOption stylix.colors.base0F;
      negative = mkStrOption stylix.colors.base08;
      neutral = mkStrOption stylix.colors.base0C;
      positive = mkStrOption stylix.colors.base0B;
      selection = mkStrOption stylix.colors.base02;
      bg = {
        dark = mkStrOption stylix.colors.base00;
        light = mkStrOption stylix.colors.base07;
        regular = mkStrOption stylix.colors.base01;
      };
      fg = {
        dark = mkStrOption stylix.colors.base04;
        light = mkStrOption stylix.colors.base06;
        regular = mkStrOption stylix.colors.base05;
      };

      accentR = mkStrOption stylix.colors.base0A-rgb-r;
      accentG = mkStrOption stylix.colors.base0A-rgb-g;
      accentB = mkStrOption stylix.colors.base0A-rgb-b;

      accentDecR = mkStrOption stylix.colors.base0A-dec-r;
      accentDecG = mkStrOption stylix.colors.base0A-dec-g;
      accentDecB = mkStrOption stylix.colors.base0A-dec-b;

      bgR = mkStrOption stylix.colors.base00-rgb-r;
      bgG = mkStrOption stylix.colors.base00-rgb-g;
      bgB = mkStrOption stylix.colors.base00-rgb-b;

      border = mkStrOption stylix.colors.base01;
      borderR = mkStrOption stylix.colors.base01-rgb-r;
      borderG = mkStrOption stylix.colors.base01-rgb-g;
      borderB = mkStrOption stylix.colors.base01-rgb-b;

      negativeR = mkStrOption stylix.colors.base08-rgb-r;
      negativeG = mkStrOption stylix.colors.base08-rgb-g;
      negativeB = mkStrOption stylix.colors.base08-rgb-b;

      neutralR = mkStrOption stylix.colors.base0C-rgb-r;
      neutralG = mkStrOption stylix.colors.base0C-rgb-g;
      neutralB = mkStrOption stylix.colors.base0C-rgb-b;

      positiveR = mkStrOption stylix.colors.base0B-rgb-r;
      positiveG = mkStrOption stylix.colors.base0B-rgb-g;
      positiveB = mkStrOption stylix.colors.base0B-rgb-b;

      transparent = mkStrOption "ffffff00";
    };

    cursor = {
      name = mkStrOption "Bibata-Modern-Custom";
      size = mkIntOption 16;
      package = mkPkgOption (
        inputs.nix-cursors.packages.${pkgs.system}.bibata-modern-cursor.override {
          accent_color = "#${cfg.color.accent}";
          background_color = "#${cfg.color.fg.light}";
          outline_color = "#${cfg.color.bg.dark}";
        }
      );
    };
    # cursor = {
    #   name = mkStrOption "phinger-cursors-light";
    #   package = mkPkgOption pkgs.phinger-cursors;
    #   size = mkIntOption 24;
    # };

    font = {
      emoji = {
        name = mkStrOption "Noto Color Emoji";
        package = mkPkgOption pkgs.noto-fonts-emoji;
      };
      monospace = {
        name = mkStrOption "Terminess Nerd Font Mono";
        package = mkPkgOption (pkgs.nerdfonts.override { fonts = [ "Terminus" ]; });
      };
      sansSerif = {
        name = mkStrOption "SF Pro Display";
        package = mkPkgOption (pkgs.callPackage <package/applefont> { });
      };
      serif = {
        name = mkStrOption "SF Pro Display";
        package = mkPkgOption (pkgs.callPackage <package/applefont> { });
      };
      size = {
        application = mkIntOption 12;
        desktop = mkIntOption 14;
        popup = mkIntOption 12;
        terminal = mkIntOption 14;
      };
    };

    opacity = {
      application = mkFloatOption 0.85;
      desktop = mkFloatOption 0.85;
      hex = mkStrOption "D9";
      popup = mkFloatOption 0.85;
      terminal = mkFloatOption 0.85;
    };

    window = {
      border = mkIntOption 4;
      gap = mkIntOption 8;
    };
  };
}

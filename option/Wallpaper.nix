# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/kMY55kW.png";
  sha256 = "sha256-OcGrjvGAs6zZY9FLPojMMSufQp4GMLWynEokZ3zJ0DA=";
  forceContrastText = false;

  # SEE: https://github.com/tinted-theming/schemes
  # Colors: #212337 #403c64 #596399 #748cd6 #a1abe0 #a3ace1 #b4a4f4 #ef43fa #ff5370 #f67f81 #ffc777 #2df4c0 #40ffff #04d1f9 #b994f1 #ecb2f0
  # scheme = "${pkgs.base16-schemes}/share/themes/moonlight.yaml";

  # Colors: #282c34 #2c323b #3e4451 #665c54 #928374 #a89984 #d5c4a1 #fdf4c1 #83a598 #a07e3b #a07e3b #528b8b #83a598 #83a598 #d75f5f #a87322
  # scheme = "${pkgs.base16-schemes}/share/themes/sandcastle.yaml";

  # Colors: #272822 #383830 #49483e #75715e #a59f85 #f8f8f2 #f5f4f1 #f9f8f5 #f92672 #fd971f #f4bf75 #a6e22e #a1efe4 #66d9ef #ae81ff #cc6633
  # scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";

  # Colors: #2E3440 #3B4252 #434C5E #4C566A #D8DEE9 #E5E9F0 #ECEFF4 #8FBCBB #BF616A #D08770 #EBCB8B #A3BE8C #88C0D0 #81A1C1 #B48EAD #5E81AC
  # scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

  # Colors: #1A1B26 #16161E #2F3549 #444B6A #787C99 #A9B1D6 #CBCCD1 #D5D6DB #C0CAF5 #A9B1D6 #0DB9D7 #9ECE6A #B4F9F8 #2AC3DE #BB9AF7 #F7768E
  # scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  # Colors: #3C4C55 #556873 #6A7D89 #899BA6 #899BA6 #C5D4DD #899BA6 #556873 #83AFE5 #7FC1CA #A8CE93 #7FC1CA #F2C38F #83AFE5 #9A93E1 #F2C38F
  # scheme = "${pkgs.base16-schemes}/share/themes/nova.yaml"; # Needs text contrast.

  # Colors: #263238 #2E3C43 #314549 #546E7A #B2CCD6 #EEFFFF #EEFFFF #FFFFFF #F07178 #F78C6C #FFCB6B #C3E88D #89DDFF #82AAFF #C792EA #FF5370
  # scheme = "${pkgs.base16-schemes}/share/themes/material.yaml";

  # Colors: #1e1e3f #43d426 #f1d000 #808080 #6871ff #c7c7c7 #ff77ff #ffffff #d90429 #f92a1c #ffe700 #3ad900 #00c5c7 #6943ff #ff2c70 #79e8fb
  # scheme = "${pkgs.base16-schemes}/share/themes/shades-of-purple.yaml";

  # Colors: #3B3228 #534636 #645240 #7e705a #b8afad #d0c8c6 #e9e1dd #f5eeeb #cb6077 #d28b71 #f4bc87 #beb55b #7bbda4 #8ab3b5 #a89bb9 #bb9584
  # scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";

  # Colors: #1d2021 #3c3836 #504945 #665c54 #bdae93 #d5c4a1 #ebdbb2 #fbf1c7 #fb4934 #fe8019 #fabd2f #b8bb26 #8ec07c #83a598 #d3869b #d65d0e
  # scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

  # Use wallpaper to generate color. SEE: /etc/stylix/palette.json
  scheme = null;
in
{
  options.module.wallpaper = {
    forceContrastText = lib.mkOption {
      default = lib.warnIf forceContrastText "Wallpaper: Forced text contrast." forceContrastText;
      type = lib.types.bool;
    };
    path = lib.mkOption {
      default = pkgs.fetchurl { inherit url sha256; };
      type = lib.types.path;
    };
    scheme = lib.mkOption {
      default = scheme;
      type =
        with lib.types;
        nullOr (oneOf [
          path
          lines
          attrs
        ]);
    };
  };
}

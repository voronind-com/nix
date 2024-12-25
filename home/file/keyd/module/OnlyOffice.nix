{ pkgs, ... }:
{
  file = (pkgs.formats.ini { }).generate "keyd-onlyoffice-config" {
    "onlyoffice-desktop-editors" = {
      "alt.a" = "home";
      "alt.b" = "pageup";
      "alt.d" = "end";
      "alt.e" = "A-pagedown";
      "alt.f" = "pagedown";
      "alt.h" = "left";
      "alt.i" = "f2";
      "alt.j" = "down";
      "alt.k" = "up";
      "alt.l" = "right";
      "alt.p" = "C-v";
      "alt.q" = "A-pageup";
      "alt.r" = "C-y";
      "alt.s" = "C-end";
      "alt.u" = "C-z";
      "alt.v" = "S-space";
      "alt.w" = "C-home";
      "alt.y" = "C-c";
    };
  };
}

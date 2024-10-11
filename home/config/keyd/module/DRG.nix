{ pkgs, ... }:
{
  file = (pkgs.formats.ini { }).generate "KeydDrgConfig" {
    steam-app-548430 = {
      "alt.1" = "macro(enter 10ms L e t ' s 10ms space d o 10ms space t h i s 10ms space T e x a s 10ms space s t y l e ! 10ms enter)";
      "alt.2" = "macro(enter 10ms H e c k space y e s ! enter)";
      "alt.3" = "macro(enter 10ms J u s t space a space s i d e - j o b space w h i l e 10ms space w a i t i n g space f o r space a space s e x space u p d a t e . enter)";
      "alt.4" = "macro(enter 10ms < 3 enter)";
      "alt.[" = "macro(enter 10ms W h a t space i s space c r u n c h y 10ms space o n space t h e space o u t s i d e , 10ms space g o o e y space o n space 10ms t h e space i n s i d e ? enter)";
      "alt.]" = "macro(enter 10ms Q ' r o n a r space S h e l l b a c k ! enter)";
      "alt.a" = "macro(enter 10ms N o enter)";
      "alt.b" = "macro(enter 10ms I ' m space b a c k enter)";
      "alt.c" = "macro(enter 10ms > space R i g h t enter)";
      "alt.d" = "macro(enter 10ms Y e s enter)";
      "alt.e" = "macro(enter 10ms T h a n k s ! enter)";
      "alt.f" = "macro(enter 10ms I space n e e d space h e l p ! enter)";
      "alt.g" = "macro(enter 10ms g g enter)";
      "alt.j" = "macro(enter 10ms G o o d space j o b enter)";
      "alt.k" = "macro(enter 10ms O k a y enter)";
      "alt.l" = "macro(enter 10ms L e a f space l o v e r enter)";
      "alt.m" = "macro(enter 10ms I space r e p l y space u s i n g space m a c r o s . 10ms space U s e space s o f t w a r e space l i k e space k e y d , 10ms space o r space b u y space a space Q M K space k e y b o a r d . enter)";
      "alt.q" = "macro(enter 10ms S o r r y ! enter)";
      "alt.r" = "macro(enter 10ms N e e d space m o r e space a m m o enter)";
      "alt.s" = "macro(enter 10ms W a i t enter)";
      "alt.t" = "macro(enter 10ms M a y space I space t a k e space e x t r a ? enter)";
      "alt.v" = "macro(enter 10ms A F K enter)";
      "alt.w" = "macro(enter 10ms r enter)";
      "alt.x" = "macro(enter 10ms > space H e r e space < enter)";
      "alt.z" = "macro(enter 10ms < space L e f t enter)";
      leftshift = "timeout(leftcontrol, 150, leftshift)";
    };
  };
}

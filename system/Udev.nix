{ pkgs, ... }:
let
  waybar_reload = pkgs.writeShellScriptBin "bt-wb-dispatcher" ''
    ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
    ${pkgs.coreutils}/bin/sleep 2
    ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
  '';
in
{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="${waybar_reload}/bin/bt-wb-dispatcher"
    ACTION=="remove", SUBSYSTEM=="bluetooth", RUN+="${waybar_reload}/bin/bt-wb-dispatcher"
  '';
}

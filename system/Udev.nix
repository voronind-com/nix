{ pkgs, ... }:
let
  btWbDispatcher = pkgs.writeShellScriptBin "bt-wb-dispatcher" ''
    ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
  '';
  btAddWbDispatcher = pkgs.writeShellScriptBin "bt-add-wb-dispatcher" ''
    ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
    ${pkgs.coreutils}/bin/sleep 2
    ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
  '';
in
{
  services.udev.extraRules = ''
    SUBSYSTEM=="bluetooth", RUN+="${btWbDispatcher}/bin/bt-wb-dispatcher"
    SUBSYSTEM=="bluetooth", ACTION=="add", RUN+="${btAddWbDispatcher}/bin/bt-add-wb-dispatcher"
  '';
}

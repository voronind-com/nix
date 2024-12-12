{
	pkgs,
	util,
	...
}: let
	waybar_reload = pkgs.writeShellScriptBin "bt-wb-dispatcher" (util.trimTabs ''
		${pkgs.procps}/bin/pkill -RTMIN+7 waybar
	'');
in {
	services.udev.extraRules = util.trimTabs ''
		ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="${waybar_reload}/bin/bt-wb-dispatcher"
		ACTION=="remove", SUBSYSTEM=="bluetooth", RUN+="${waybar_reload}/bin/bt-wb-dispatcher"
	'';
}

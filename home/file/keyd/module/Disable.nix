{
	pkgs,
	...
}: let
	apps = [
		"gimp"
		"gimp-*"
		"steam-proton"
	];

	keys = [
		"escape"
		"leftcontrol"
	];
in {
	file = let
		keySets = builtins.map (key: {
			name  = key;
			value = key;
		}) keys;

		appSets = builtins.map (app: {
			name  = app;
			value = builtins.listToAttrs keySets;
		}) apps;
	in
		(pkgs.formats.ini { }).generate "KeydDisableConfig" (builtins.listToAttrs appSets);
}
{
	__findFile,
	pkgs,
	...
}: let
	wm2fc = pkgs.callPackage <package/wm2fc> {};
in {
	environment.systemPackages = with pkgs; [
		wm2fc
	];

	security.wrappers.wm2fc = {
		source = "${wm2fc}/bin/wm2fc";
		owner  = "root";
		group  = "root";
		setuid = true;
		permissions = "u+rx,g+x,o+x";
	};
}

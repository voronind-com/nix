# HACK: Add a patch for https://github.com/rvaiya/keyd/pull/545
{
	lib,
	util,
	...
}: {
	nixpkgs.overlays = [(final: prev: {
		keyd = prev.keyd.overrideAttrs (old: rec {
			patches = (old.patches or [ ]) ++ [
				(prev.fetchpatch {
					hash = "sha256-aal8oAXws6DcpeCl7G9GMJQXeLDDbyotWFut0Rf82WI=";
					url  = "https://patch-diff.githubusercontent.com/raw/rvaiya/keyd/pull/545.patch";
				})
			];

			postInstall = let
				pypkgs = prev.python3.pkgs;
				appMap = pypkgs.buildPythonApplication rec {
					inherit (prev.keyd) version src;
					inherit patches;
					dontBuild = true;
					format    = "other";
					meta.mainProgram = "keyd-application-mapper";
					pname            = "keyd-application-mapper";
					postPatch = util.trimTabs ''
						substituteInPlace scripts/${pname} \
							--replace /bin/sh ${prev.runtimeShell}
					'';
					propagatedBuildInputs = with pypkgs; [
						xlib
					];
					installPhase = util.trimTabs ''
						install -Dm555 -t $out/bin scripts/${pname}
					'';
				};
			in ''
				ln -sf ${lib.getExe appMap} $out/bin/${appMap.pname}
				rm -rf $out/etc
			'';
		});
	})];
}

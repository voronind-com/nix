# HACK: Add a patch for https://github.com/rvaiya/keyd/pull/545
{ lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      keyd = prev.keyd.overrideAttrs (old: rec {
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/rvaiya/keyd/pull/545.patch";
            hash = "sha256-aal8oAXws6DcpeCl7G9GMJQXeLDDbyotWFut0Rf82WI=";
          })
        ];

        postInstall =
          let
            pypkgs = prev.python3.pkgs;
            appMap = pypkgs.buildPythonApplication rec {
              inherit (prev.keyd) version src;
              inherit patches;

              pname = "keyd-application-mapper";
              format = "other";

              postPatch = ''
                substituteInPlace scripts/${pname} \
                  --replace /bin/sh ${prev.runtimeShell}
              '';

              propagatedBuildInputs = with pypkgs; [ xlib ];

              dontBuild = true;

              installPhase = ''
                install -Dm555 -t $out/bin scripts/${pname}
              '';

              meta.mainProgram = "keyd-application-mapper";
            };
          in
          ''
            ln -sf ${lib.getExe appMap} $out/bin/${appMap.pname}
            rm -rf $out/etc
          '';
      });
    })
  ];
}

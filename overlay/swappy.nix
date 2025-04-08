{
  __findFile,
  config,
  pkgs,
  ...
}:
let
  inherit (config.module.style) color;
  accentR = color.accentDecR;
  accentG = color.accentDecG;
  accentB = color.accentDecB;
in
{
  # SEE: https://github.com/jtheoof/swappy/issues/131
  nixpkgs.overlays = [
    (final: prev: {
      swappy = prev.swappy.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (pkgs.replaceVars <patch/swappy/default-color.patch> { inherit accentR accentG accentB; })
        ];
      });
    })
  ];
}

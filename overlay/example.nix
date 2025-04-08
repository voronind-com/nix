# Example overlay file.
# Overlays can change parameters in package builds, like source version.
# This way you can change something in package without recreating the whole build process.
# More info: https://nixos.wiki/wiki/Overlays
{
  # Use a different revision.
  # nixpkgs.overlays = [ (final: prev: {
  #   yt-dlp = prev.yt-dlp.overrideAttrs (old: {
  #     src = prev.fetchFromGitHub {
  #       owner = "yt-dlp";
  #       repo  = "yt-dlp";
  #       rev   = "2024.03.10";
  #       hash  = "sha256-A6uciGErM4QgLrY5jMFGlPV2uH9O2cOhj5+IapyjVo0=";
  #     };
  #   });
  # })];

  # Apply patch to a program.
  # nixpkgs.overlays = [ (final: prev: {
  #   keyd = prev.keyd.overrideAttrs (old: {
  #     patches = (old.patches or []) ++ [(prev.fetchpatch {
  #       url   = "https://patch-diff.githubusercontent.com/raw/rvaiya/keyd/pull/545.patch";
  #       hash  = "sha256-aal8oAXws6DcpeCl7G9GMJQXeLDDbyotWFut0Rf82WI=";
  #     })];
  #   });
  # })];
}

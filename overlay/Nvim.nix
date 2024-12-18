{ __findFile, ... }:
{
  # SEE: https://github.com/neovim/neovim/issues/22478
  nixpkgs.overlays = [
    (final: prev: {
      neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ <patch/nvim/PressEnter.patch> ];
      });
    })
  ];
}

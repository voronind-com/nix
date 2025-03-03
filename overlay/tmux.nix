{ __findFile, ... }:
{
  # SEE: https://github.com/tmux/tmux/issues/4264
  # FIXME: Later. When you get no error on start on Android.
  nixpkgs.overlays = [
    (final: prev: {
      tmux = prev.tmux.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          hash = "sha256-EuTEN+B+rE76nLQRIljy2PL2gp+rVGk+ygEhQA2nZww=";
          owner = "tmux";
          repo = "tmux";
          rev = "db978db27161f57b01f22407d2dda2bce203c2cf";
        };
        patches = (old.patches or [ ]) ++ [ <patch/tmux/selection_style.patch> ];
      });
    })
  ];
}

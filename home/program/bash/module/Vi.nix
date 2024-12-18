{ ... }:
{
  text = ''
    # Neovim shortcut.
    function v() {
      nvim -- "''${@}"
    }
  '';
}

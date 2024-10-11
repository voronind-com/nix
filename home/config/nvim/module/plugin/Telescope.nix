{ ... }:
{
  text = ''
    require("telescope").setup{
      defaults = {
        mappings = {
          i = {
            ["<C-?>"] = "which_key",
          }
        }
      },
      extensions = { },
      pickers    = { },
    }
  '';
}

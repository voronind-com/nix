{ ... }:
{
  text = ''
    require("telescope").setup{
      defaults = {
        mappings = {
          i = {
            ["<Tab>"] = "move_selection_previous",
            ["<S-Tab>"] = "move_selection_next",
          },
        },
      },
      extensions = { },
      pickers    = { },
    }
  '';
}

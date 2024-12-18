{ ... }:
{
  text = ''
    function toggle_contrast()
      if vim.g.gruvbox_material_background == "light" then
        vim.g.gruvbox_material_background = "medium"
      elseif vim.g.gruvbox_material_background == "medium" then
        vim.g.gruvbox_material_background = "hard"
      elseif vim.g.gruvbox_material_background == "hard" then
        vim.g.gruvbox_material_background = "light"
      end
      vim.cmd("colorscheme gruvbox-material")
    end

    function toggle_light()
      if vim.o.background == "light" then
        vim.o.background = "dark"
      elseif vim.o.background == "dark" then
        vim.o.background = "light"
      end
      -- require("lualine").setup()
    end

    rekey_normal("<Leader>[", "<cmd>lua toggle_contrast()<cr>")
    rekey_normal("<Leader>]", "<cmd>lua toggle_light()<cr>")
  '';
}

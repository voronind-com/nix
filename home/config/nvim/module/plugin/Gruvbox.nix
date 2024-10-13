{ ... }:
{
  text = ''
    vim.cmd([[
      if has('termguicolors')
        set termguicolors
      endif
    ]])

    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_transparent_background = 2
    -- vim.g.gruvbox_material_better_performance = 1 -- NOTE: Broken on NixOS.

    -- vim.cmd("autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("let g:lightline = {'colorscheme' : 'gruvbox_material'}")
  '';
}

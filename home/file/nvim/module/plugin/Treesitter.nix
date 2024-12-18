{ ... }:
{
  text = ''
    require("nvim-treesitter.configs").setup {
      parser_install_dir = "~/.cache/nvim/treesitter",
      auto_install     = true,
      -- ensure_installed = "all",
      sync_install     = false,
      highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
        use_languagetree = true,
        disable = { "lua" },
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true
      },
      rainbow = {
        enable = true
      },
    }
  '';
}

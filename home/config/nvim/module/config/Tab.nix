{ ... }:
let
  indentDefault = 2;
in
{
  text = ''
    vim.opt.autoindent  = true
    vim.opt.expandtab   = false
    -- vim.opt.smartindent = true
    vim.opt.shiftwidth  = ${toString indentDefault}
    vim.opt.softtabstop = ${toString indentDefault}
    vim.opt.tabstop     = ${toString indentDefault}

    -- Disable Markdown forced formatting.
    vim.g.markdown_recommended_style = 0
  '';
}

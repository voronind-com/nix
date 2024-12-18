{ ... }:
{
  text = ''
    function toggle_tab_width()
      if vim.bo.shiftwidth == 2 then
        vim.bo.shiftwidth  = 4
        vim.bo.tabstop     = 4
        vim.bo.softtabstop = 4
      elseif vim.bo.shiftwidth == 4 then
        vim.bo.shiftwidth  = 8
        vim.bo.tabstop     = 8
        vim.bo.softtabstop = 8
      elseif vim.bo.shiftwidth == 8 then
        vim.bo.shiftwidth  = 2
        vim.bo.tabstop     = 2
        vim.bo.softtabstop = 2
      end
    end

    rekey_normal("<Leader><Tab>", "<cmd>lua toggle_tab_width()<cr>")
  '';
}

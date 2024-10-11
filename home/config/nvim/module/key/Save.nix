{ ... }:
{
  text = ''
    -- Write all we can and exit. Created this to drop non-writable stuff when piping to nvim.
    function bye()
      pcall(vim.cmd, "wa")
      vim.cmd[[qa!]]
    end

    -- Save everything.
    rekey_normal("<C-s>", "<cmd>wa!<cr>")
    rekey_input("<C-s>", "<cmd>wa!<cr>")

    -- Save all we can and leave.
    rekey_normal("<Leader>z", "<cmd>lua bye()<cr>")

    -- Just leave, no saves.
    rekey_normal("<Leader>Z", "<cmd>qa!<cr>")
  '';
}

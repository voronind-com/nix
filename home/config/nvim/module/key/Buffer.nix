{ ... }:
{
  text = ''
    -- New empty buffer.
    remap_normal("<Leader>n", "<cmd>enew<cr>")

    -- Close buffer.
    function _buf_close()
      pcall(vim.cmd, "w")
      vim.cmd[[bp|sp|bn|bd!]]
    end
    rekey_normal("<Leader>x", "<cmd>lua _buf_close()<cr>")

    -- Close all hidden buffers.
    rekey_normal("<Leader>X", "<cmd>BDelete hidden<cr><C-l>")
  '';
}

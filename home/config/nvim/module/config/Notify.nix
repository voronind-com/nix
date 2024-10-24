{ ... }:
{
  text = ''
    -- Disable error messages popup.
    -- Instead print them and write to system journal.
    bequiet = function(msg, log_level, opts)
      print(string.sub(tostring(msg), 1, vim.v.echospace))

      local log = io.popen("systemd-cat -t nvim", "w")
      log:write(tostring(msg))
      log:close()
    end

    vim.notify = bequiet
    vim.api.nvim_out_write = bequiet
    vim.api.nvim_err_write = bequiet
    vim.api.nvim_err_writeln = bequiet
  '';
}

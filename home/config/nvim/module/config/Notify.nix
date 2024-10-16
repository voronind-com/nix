{ ... }:
{
  text = ''
    pid = vim.fn.getpid()

    -- Disable error messages popup.
    -- Instead print them and write to /tmp/NeovimError<PID>.txt
    bequiet = function(msg, log_level, opts)
      print(string.sub(tostring(msg), 1, vim.v.echospace))

      local file = io.open("/tmp/NeovimError"..tostring(pid)..".txt", "a")
      file:write(msg.."\n")
      file:close()
    end

    vim.notify = bequiet
    vim.api.nvim_err_writeln = bequiet
  '';
}

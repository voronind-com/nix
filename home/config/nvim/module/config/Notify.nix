{ ... }:
{
  text = ''
    pid = vim.fn.getpid()

    -- Disable error messages popup.
    -- Instead print them and write to /tmp/NeovimError<PID>.txt
    vim.notify = function(msg, log_level, opts)
      print(string.sub(msg, 1, vim.v.echospace))

      local file = io.open("/tmp/NeovimError"..tostring(pid)..".txt", "a")
      file:write(msg.."\n")
      file:close()
    end
  '';
}

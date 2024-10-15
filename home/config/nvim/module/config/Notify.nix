{ ... }:
{
  text = ''
    -- Disable error messages popup.
    -- Instead write them to /tmp/NeovimError<PID>.txt
    vim.notify = function(msg, log_level, opts)
      local pid  = vim.fn.getpid()
      local file = io.open("/tmp/NeovimError"..tostring(pid)..".txt", "a")
      file:write(msg.."\n")
      file:close()
    end
  '';
}

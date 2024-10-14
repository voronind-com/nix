{ ... }:
{
  text = ''
    -- Disable error messages.
    vim.notify = function(msg, log_level, opts)
      return
    end
  '';
}

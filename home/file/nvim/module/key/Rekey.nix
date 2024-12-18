{ ... }:
{
  text = ''
    -- Base rekey function.
    local function rekey(t, key, command)
      vim.api.nvim_set_keymap(t, key, command, { noremap = true })
    end

    -- Base remap function.
    local function remap(t, key, command)
      vim.api.nvim_set_keymap(t, key, command, { noremap = false })
    end

    -- Rekey in normal mode.
    function rekey_normal(key, command)
      rekey("n", key, command)
    end

    -- Rekey in input mode.
    function rekey_input(key, command)
      rekey("i", key, command)
    end

    -- Rekey in visual mode.
    function rekey_visual(key, command)
      rekey("v", key, command)
    end

    -- Rekey in terminal mode.
    function rekey_terminal(key, command)
      rekey("t", key, command)
    end

    -- Remap in normal mode.
    function remap_normal(key, command)
      remap("n", key, command)
    end

    -- Remap in input mode.
    function remap_input(key, command)
      remap("i", key, command)
    end

    -- Remap in visual mode.
    function remap_visual(key, command)
      remap("v", key, command)
    end

    -- Remap in terminal mode.
    function remap_terminal(key, command)
      remap("t", key, command)
    end
  '';
}

{ config, lib, ... }:
let
  color = config.module.style.color;
  mkHighlight =
    name: value:
    ''vim.api.nvim_set_hl(0, "${name}", ${
      lib.generators.toLua {
        multiline = false;
        asBindings = false;
      } value
    })'';
  bg = {
    bg = "#${color.bg.regular}";
  };
  selection = {
    bg = "#${color.selection}";
    bold = true;
    fg = "#${color.fg.dark}";
  };
  transparent = {
    bg = lib.generators.mkLuaInline "clear";
  };
  border = {
    bg = lib.generators.mkLuaInline "clear";
    fg = "#${color.accent}";
  };
in
{
  text = ''
    vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
      group   = vim.api.nvim_create_augroup('Color', {}),
      pattern = "*",
      callback = function ()
        -- Background.
        ${mkHighlight "CursorLine" bg}
        ${mkHighlight "Pmenu" bg}
        ${mkHighlight "PmenuExtra" bg}
        ${mkHighlight "TelescopeSelection" bg}

        -- Selection.
        ${mkHighlight "Visual" selection}
        ${mkHighlight "PmenuSel" selection}

        -- Transparent.
        ${mkHighlight "NormalFloat" transparent}

        -- Border.
        ${mkHighlight "FloatBorder" border}
        ${mkHighlight "FloatTitle" border}
        ${mkHighlight "TelescopeBorder" border}
      end
    })
  '';
}

{ config, lib, ... }: let
	color = config.style.color;

	mkHighlight = name: value: ''vim.api.nvim_set_hl(0, "${name}", ${lib.generators.toLua { multiline = false; asBindings = false; } value})'';

	bg          = { bg = "#${color.bg.regular}"; };
	selection   = { bg = "#${color.selection}"; fg = "#${color.fg.dark}"; bold = true; };
	transparent = { bg = lib.generators.mkLuaInline "clear"; };
in {
	text = ''
		vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
			group   = vim.api.nvim_create_augroup('Color', {}),
			pattern = "*",
			callback = function ()
				-- Backgrounds.
				${mkHighlight "CursorLine"         bg}
				${mkHighlight "TelescopeSelection" bg}

				-- Selection.
				${mkHighlight "Visual" selection}

				-- Transparent.
				${mkHighlight "NormalFloat" transparent}
			end
		})
	'';
}

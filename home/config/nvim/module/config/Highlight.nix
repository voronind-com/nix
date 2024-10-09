{ config, lib, ... }: let
	color = config.style.color;

	mkHighlight = name: value: ''vim.api.nvim_set_hl(0, "${name}", ${lib.generators.toLua { multiline = false; asBindings = false; } value})'';

	selection   = { bg = "#${color.bg.regular}"; };
	transparent = { bg = lib.generators.mkLuaInline "clear"; };
in {
	text = ''
		vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
			group   = vim.api.nvim_create_augroup('Color', {}),
			pattern = "*",
			callback = function ()
				-- Selection.
				${mkHighlight "CursorLine"         selection}
				${mkHighlight "Visual"             selection}
				${mkHighlight "TelescopeSelection" selection}

				-- Transparent.
				${mkHighlight "NormalFloat" transparent}
			end
		})
	'';
}

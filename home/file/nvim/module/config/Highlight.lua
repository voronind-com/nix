vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("Color", {}),
	pattern = "*",
	callback = function()
		-- Background.
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#@bg@" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#@bg@" })
		vim.api.nvim_set_hl(0, "PmenuExtra", { bg = "#@bg@" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#@bg@" })

		-- Selection.
		vim.api.nvim_set_hl(0, "Visual", { bg = "#@selection@", bold = true, fg = "#@fg@" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#@selection@", bold = true, fg = "#@fg@" })

		-- Transparent.
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = clear })

		-- Border.
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = clear, fg = "#@accent@" })
		vim.api.nvim_set_hl(0, "FloatTitle", { bg = clear, fg = "#@accent@" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = clear, fg = "#@accent@" })
	end,
})

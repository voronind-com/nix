{ ... }: {
	text = ''
		require("autoclose").setup({
			keys = {
				["'"]  = { escape = false, close = false, pair = "''''''",   disabled_filetypes = {} },
				["("]  = { escape = true,  close = true,  pair = "()",   disabled_filetypes = {} },
				["<"]  = { escape = true,  close = true,  pair = "<>",   disabled_filetypes = {} },
				["\""] = { escape = true,  close = true,  pair = "\"\"", disabled_filetypes = {} },
				["`"]  = { escape = true,  close = true,  pair = "``",   disabled_filetypes = {} },
				["{"]  = { escape = true,  close = true,  pair = "{}",   disabled_filetypes = {} },
			},
			-- options = {
			--   disabled_filetypes = { "text", "markdown" },
			-- }
		})
	'';
}

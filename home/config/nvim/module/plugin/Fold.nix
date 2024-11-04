{ ... }: {
	text = ''
		vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel  = 99
		vim.opt.foldmethod = "expr"
	'';
}

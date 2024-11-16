{ ... }: {
	text = ''
		local lspconfig = require("lspconfig")

		lspconfig.hls.setup {
			filetypes = { 'haskell', 'lhaskell', 'cabal' },
		}
	'';
}

local lspconfig = require("lspconfig")

lspconfig.nixd.setup({
	settings = {
		nixd = {
			diagnostic = {
				suppress = {
					"sema-escaping-with",
				},
			},
		},
	},
})

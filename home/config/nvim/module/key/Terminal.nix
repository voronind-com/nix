{ ... }: {
	text = ''
		-- Open terminal window.
		rekey_normal("<Leader>4", "<cmd>terminal<cr>")

		-- Detach from terminal with Esc key.
		rekey_terminal("<Esc>", "<C-\\><C-n>")
	'';
}

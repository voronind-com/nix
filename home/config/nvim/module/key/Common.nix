{ ... }: {
	text = ''
		-- Write all we can and exit. Created this to drop non-writable stuff when piping to nvim.
		function bye()
			pcall(vim.cmd, "wa")
			vim.cmd[[qa!]]
		end

		function toggle_tab_width()
			if vim.bo.shiftwidth == 2 then
				vim.bo.shiftwidth  = 4
				vim.bo.tabstop     = 4
				vim.bo.softtabstop = 4
			elseif vim.bo.shiftwidth == 4 then
				vim.bo.shiftwidth  = 8
				vim.bo.tabstop     = 8
				vim.bo.softtabstop = 8
			elseif vim.bo.shiftwidth == 8 then
				vim.bo.shiftwidth  = 2
				vim.bo.tabstop     = 2
				vim.bo.softtabstop = 2
			end
		end

		rekey_normal("<Leader><Tab>", "<cmd>lua toggle_tab_width()<cr>")

		-- Repeat previous command.
		rekey_normal("<Leader>.", "@:")
		rekey_visual("<Leader>.", "@:")

		-- Save everything.
		rekey_normal("<C-s>", "<cmd>wa!<cr>")

		-- Save all we can and leave.
		rekey_normal("<Leader>z", "<cmd>lua bye()<cr>")

		-- Just leave, no saves.
		rekey_normal("<Leader>Z", "<cmd>qa!<cr>")

		-- Remap ; to :.
		rekey_normal(";", ":")
		rekey_visual(";", ":")
	'';
}

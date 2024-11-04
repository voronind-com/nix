{ ... }: {
	text = ''
		-- Disable netrw at the very start of your init.lua.
		vim.g.loaded_netrw       = 1
		vim.g.loaded_netrwPlugin = 1

		local function my_on_attach(bufnr)
			local api = require "nvim-tree.api"

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings.
			api.config.mappings.default_on_attach(bufnr)

			-- Custom mappings.
			-- vim.keymap.set('n', '<Leader><Tab>', api.tree.change_root_to_node, opts('Cd into'))
		end

		-- Set termguicolors to enable highlight groups.
		vim.opt.termguicolors = true

		-- Setup nvim-tree.
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			sort_by   = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles    = false,
				git_ignored = false
			},
		})
	'';
}

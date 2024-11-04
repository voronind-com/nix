{ ... }: {
	text = ''
		require("gitsigns").setup {
			signs = {
				add          = { text = "│" },
				change       = { text = "│" },
				changedelete = { text = "~" },
				delete       = { text = "_" },
				topdelete    = { text = "‾" },
				untracked    = { text = "┆" },
			},
			linehl     = false,
			numhl      = true,
			signcolumn = false,
			word_diff  = false,
			watch_gitdir = {
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame  = false,
			current_line_blame_opts = {
				delay             = 1000,
				ignore_whitespace = false,
				virt_text         = true,
				virt_text_pos     = "eol",
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			max_file_length  = 40000,
			sign_priority    = 6,
			status_formatter = nil,
			update_debounce  = 100,
			preview_config = {
				border   = "single",
				col      = 1,
				relative = "cursor",
				row      = 0,
				style    = "minimal",
			},
		}

		-- Set custom color.
		vim.cmd("highlight gitsignscurrentlineblame guibg=#00000000 guifg=#aaaaaa")
	'';
}

{ ... }: {
	text = ''
		require("close_buffers").setup({
			file_glob_ignore  = {},
			file_regex_ignore = {},
			filetype_ignore   = {},
			next_buffer_cmd   = nil,
			preserve_window_layout = { "this", "nameless" },
		})
	'';
}

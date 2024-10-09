{ config, ... }: let
	cfg = config.style.color;

	bg = cfg.bg.regular;
in {
	# TODO: Create a function to set group color.
	text = ''
		vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
		group = vim.api.nvim_create_augroup('Color', {}),
		pattern = "*",
		callback = function ()
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#${bg}" })
		end
})
	'';
}

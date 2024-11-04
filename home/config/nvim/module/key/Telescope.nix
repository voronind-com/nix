{ ... }: let
	mod = "f";
in {
	text = ''
		rekey_normal("<Leader>${mod}a", "<cmd>Telescope<cr>")
		rekey_normal("<Leader>${mod}b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
		rekey_normal("<Leader>${mod}f", "<cmd>lua require('telescope.builtin').find_files()<cr>")
		rekey_normal("<Leader>${mod}g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
		rekey_normal("<Leader>${mod}h", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
		rekey_normal("<Leader>${mod}t", "<cmd>Telescope treesitter<cr>")
	'';
}

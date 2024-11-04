{ ... }: {
	text = ''
		-- Remap ; to :.
		rekey_normal(";", ":")
		rekey_visual(";", ":")

		-- Repeat previous command.
		rekey_normal("<Leader>.", "@:")
		rekey_visual("<Leader>.", "@:")
	'';
}

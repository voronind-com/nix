{
	config,
	...
}: {
	text = ''
		require("gen").setup {
			model = "${config.module.ollama.primaryModel or ""}"
		}
	'';
}

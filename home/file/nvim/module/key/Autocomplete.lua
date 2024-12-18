-- Autocomplete.
rekey_input("<C-space>", "<C-n>")

-- LSP autocomplete.
rekey_normal("<C-space>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

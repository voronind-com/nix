-- Switch windows.
rekey_normal("<Leader>a", "<C-w>h")
rekey_normal("<Leader>d", "<C-w>l")
rekey_normal("<Leader>s", "<C-w>j")
rekey_normal("<Leader>w", "<C-w>k")

-- Switch buffers.
rekey_normal("<Leader>E", "<cmd>BufferLineMoveNext<cr>")
rekey_normal("<Leader>Q", "<cmd>BufferLineMovePrev<cr>")
rekey_normal("<Leader>e", "<cmd>BufferLineCycleNext<cr>")
rekey_normal("<Leader>q", "<cmd>BufferLineCyclePrev<cr>")

-- Splits.
rekey_normal("<Leader>\\", "<cmd>vsplit<cr>")
rekey_normal("<Leader>-", "<cmd>split<cr>")
rekey_normal("<Leader>=", "<C-w>=") -- Equalize split sizes.
rekey_normal("<Leader>c", "<C-w>q") -- Close split.

-- Resize splits.
rekey_normal("<Leader>h", "4<C-w><")
rekey_normal("<Leader>l", "4<C-w>>")
rekey_normal("<Leader>j", "2<C-w>+")
rekey_normal("<Leader>k", "2<C-w>-")

-- Move splits.
rekey_normal("<Leader>A", "<C-w>A")
rekey_normal("<Leader>D", "<C-w>D")
rekey_normal("<Leader>S", "<C-w>S")
rekey_normal("<Leader>W", "<C-w>W")

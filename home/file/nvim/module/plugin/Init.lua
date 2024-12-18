local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://git.voronind.com/mirror/packer.nvim.git", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local available = function(commands)
	for _, command in ipairs(commands) do
		if vim.fn.executable(command) ~= 1 then
			return false
		end
	end
	return true
end

return require("packer").startup(function(use)
	use("https://git.voronind.com/mirror/SingleComment.nvim.git")
	use("https://git.voronind.com/mirror/autoclose.nvim.git")
	use("https://git.voronind.com/mirror/bufferline.nvim.git")
	use("https://git.voronind.com/mirror/close-buffers.nvim.git")
	use("https://git.voronind.com/mirror/gitsigns.nvim.git")
	use("https://git.voronind.com/mirror/gruvbox-material.git")
	use("https://git.voronind.com/mirror/indent-o-matic.git")
	use("https://git.voronind.com/mirror/lualine.nvim.git")
	use("https://git.voronind.com/mirror/mini.align.git")
	use("https://git.voronind.com/mirror/nvim-lspconfig.git")
	use("https://git.voronind.com/mirror/nvim-tree.lua.git")
	use("https://git.voronind.com/mirror/nvim-treesitter.git")
	use("https://git.voronind.com/mirror/nvim-web-devicons.git")
	use("https://git.voronind.com/mirror/packer.nvim.git")
	use("https://git.voronind.com/mirror/plenary.nvim.git")
	use("https://git.voronind.com/mirror/telescope.nvim.git")
	use("https://git.voronind.com/mirror/todo-comments.nvim.git")
	use("https://git.voronind.com/mirror/tokyonight.nvim.git")
	use("https://git.voronind.com/mirror/trouble.nvim.git")
	use("https://git.voronind.com/mirror/which-key.nvim.git")

	-- Auto-install.
	if packer_bootstrap then
		require("packer").sync()
	end
end)

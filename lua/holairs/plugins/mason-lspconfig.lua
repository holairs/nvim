-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({})
	end,
}

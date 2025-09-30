return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			auto_install = true,
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"c",
				"rust",
				"c_sharp",
				"razor",
			},
			sync_install = true,
			ignore_install = {},
			modules = {},
			incremental_selection = { enable = false },
		})
	end,
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "windwp/nvim-ts-autotag" },
	config = function()
		-- auto close and auto rename html tags
		require("nvim-ts-autotag").setup()
		-- treesitter
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			auto_install = true,
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
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

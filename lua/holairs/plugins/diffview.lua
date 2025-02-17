return {
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gd", ":DiffviewOpen<CR>",  desc = "Open Diffview",  mode = "n", noremap = true, silent = true },
			{ "<leader>gq", ":DiffviewClose<CR>", desc = "Close Diffview", mode = "n", noremap = true, silent = true },
		},
		config = function()
			require("diffview").setup({})
		end,
	},
}

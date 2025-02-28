return {
	{
		"olimorris/codecompanion.nvim",
		keys = {
			{
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				desc = "Toggle Code Companion Chat",
			},
			{
				"<leader>co",
				"<cmd>CodeCompanionActions<cr>", -- Atajo para abrir el action palette
				mode = { "n", "v" },
				desc = "Open Code Companion Actions",
			},
		},
		config = function()
			require("codecompanion").setup({})
		end,
	},
}

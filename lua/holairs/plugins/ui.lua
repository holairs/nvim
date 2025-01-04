return {
	{

		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({})
			vim.defer_fn(function()
				local set = vim.api.nvim_set_hl
				local borders = {
					"NoiceCmdlinePopupBorder",
					"NoiceCmdlinePopupBorderCalculator",
					"NoiceCmdlinePopupBorderCmdline",
					"NoiceCmdlinePopupBorderFilter",
					"NoiceCmdlinePopupBorderHelp",
					"NoiceCmdlinePopupBorderIncRename",
					"NoiceCmdlinePopupBorderInput",
					"NoiceCmdlinePopupBorderLua",
					"NoiceCmdlinePopupBorderSearch",
					"NoiceCmdlinePopupTitle",
					"NoiceConfirmBorder",
					"NoicePopupBorder",
					"NoicePopupmenuBorder",
					"NoiceSplitBorder",
					"NoiceCmdlineIcon",
					"NoiceCmdlineIconCalculator",
					"NoiceCmdlineIconCmdline",
					"NoiceCmdlineIconFilter",
					"NoiceCmdlineIconHelp",
					"NoiceCmdlineIconInput",
					"NoiceCmdlineIconLua",
					"NoiceCmdlineIconSearch",
				}
				for _, group in ipairs(borders) do
					set(0, group, { fg = "none", bg = "none" })
				end
			end, 100) -- Retrasa 100ms para asegurarte de que se apliquen los cambios
		end,
	},
}

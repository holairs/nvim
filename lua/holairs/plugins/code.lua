return {
	{
		"windwp/nvim-ts-autotag",
		event = "BufRead",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
	},
}

return {
	{
		'echasnovski/mini.statusline',
		version = '*',
		event = "BufReadPost",
		config = function()
			require('mini.statusline').setup()
		end,
	},
}

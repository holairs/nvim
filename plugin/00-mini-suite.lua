-- plugin/00-mini-suite.lua

vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		version = vim.version.range("*"),
	},
})

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.icons").setup()
require("mini.cmdline").setup()

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {
			add = "+",
			change = "~",
			delete = "_",
		},
	},
	options = {
		diff_args = {},
		edit_dwim = true,
	},
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

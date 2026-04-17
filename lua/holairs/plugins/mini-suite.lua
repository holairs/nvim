return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.icons").setup()
		require("mini.cmdline").setup()

		-- Git signs
		require("mini.diff").setup({
			view = {
				style = "sign", -- side columns stile
				signs = {
					add = "+",
					change = "~",
					delete = "_",
				},
			},
			options = {
				diff_args = {},
				edit_dwim = true, -- "Do What I Mean"
			},
		})

		-- inline colors highlight
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end,
}

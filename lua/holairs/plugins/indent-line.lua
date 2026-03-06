return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "│", -- light = "┆", medium = "┊", bold = "┋", line = "│"
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
		},
	},
}

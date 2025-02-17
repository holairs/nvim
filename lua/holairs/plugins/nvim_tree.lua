-- Configuration for NvimTree
return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<leader>er",
				function()
					require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
				end,
			},
			{
				"<leader>ew",
				function()
					require("nvim-tree.api").tree.collapse_all()
				end,
			},
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
				},
				renderer = {
					icons = {
						show = {
							folder_arrow = false,
						},
						glyphs = {
							default = "",
							symlink = "",
							git = {
								unstaged = "",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
							folder = {
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
							},
						},
					},
				},
				view = {
					side = "right",
					width = 30,
					number = true,
					relativenumber = true,
				},
			})
			-- transparent background
			vim.cmd([[ highlight NvimTreeNormal guibg=NONE ctermbg=NONE ]])
		end,
	},
}

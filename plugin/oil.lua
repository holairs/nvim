-- FILE: plugin/oil.lua
-- PURPOSE: Instalar y configurar oil.nvim
------------------------------------------------

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = true,
				skip_confirms_for_simple_edits = true,
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".DS_Store" or name == ".git"
					end,
				},
				win_options = { wrap = true },
				-- Floating window options
				float = {
					padding = 2,
					max_width = 60,
					max_height = 15,
					border = "rounded", -- Options: "none", "single", "double", "rounded"
					win_options = { winblend = 0 }, --Transparency
				},
})

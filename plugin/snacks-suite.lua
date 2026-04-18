-- plugin/snacks-suite.lua

vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

Snacks = require("snacks")

Snacks.setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	explorer = { enabled = true },
	statuscolumn = { enabled = true },
	words = {
		enabled = true,
		debounce = 200,
		notify_jump = false,
		notify_end = true,
		foldopen = true,
		jumplist = true,
		modes = { "n" },
	},
	picker = {
		exclude = {
			".git",
			"node_modules",
			"target",
		},
		layout = {
			preset = "ivy_split", -- Compact Layout
			cycle = false, -- Disable cicle list
		},
		matcher = { frecency = true }, -- Show most used files first
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["J"] = { "preview_scroll_down", mode = { "i", "n" } },
					["K"] = { "preview_scroll_up", mode = { "i", "n" } },
					["H"] = { "preview_scroll_left", mode = { "i", "n" } },
					["L"] = { "preview_scroll_right", mode = { "i", "n" } },
				},
			},
		},
		sources = {
			files = {
				ignored = false, -- No mostrar archivos del .gitignore
				hidden = false, -- No mostrar archivos ocultos (.env, etc)
			},
			explorer = {
				ignored = false,
				layout = { layout = { position = "right" } },
			},
		},
	},
})

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			input = { enabled = true },
			explorer = {
				enabled = true,
			},
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
				layout = {
					preset = "ivy_split", -- Layout compacto
					cycle = false,   -- No ciclar al llegar al final
				},
				matcher = {
					frecency = true, -- Priorizar archivos usados frecuentemente
				},
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
    explorer = {
      layout = {
        preset = "sidebar",
        -- preview = false,
        layout = {
          position = "right",
        },
      },
    },
  },
			},
		},
		keys = {
			-- Git
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			-- Terminal
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				mode = { "n", "t" },
				desc = "Toggle Terminal",
			},
			-- Navegación entre referencias
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			-- Buscar archivos y buffers
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find in Files",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Change Colorscheme",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "LSP References",
			},
			{
				"<leader>er",
				function()
					Snacks.explorer.reveal()
				end,
				desc = "Toggle Explorer",
			},
		},
		init = function()
			Snacks = require("snacks")
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				end,
			})
		end,
	},
}

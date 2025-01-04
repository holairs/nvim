local keymap = vim.keymap
local api = vim.api

return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>fa",
				":lua require('conform').format({ async = true })<CR>",
				desc = "Format file",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					lua = { "stylua" },
					rust = { "rustfmt" },
					python = { "black" },
				},
			})
		end,
	},

	-- Configuration for "Oil.nvim" explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>ee",
				function()
					local oil = require("oil")
					local bufnr = api.nvim_get_current_buf()
					local bufname = api.nvim_buf_get_name(bufnr)
					-- Check if the current buffer is an oil buffer
					if bufname:match("^oil://") then
						-- If it's open, close it
						oil.close()
					else
						-- If it's not open, open it as a floating window
						oil.open_float()
					end
				end,
				desc = "Toggle Oil floating file explorer",
			},
		},
		config = function()
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
				win_options = {
					wrap = true,
				},
				-- Floating window options
				float = {
					padding = 2,
					max_width = 70,
					max_height = 25,
					border = "double", -- Options: "none", "single", "double", "rounded", etc.
					win_options = {
						winblend = 0, -- Transparency
					},
				},
			})
		end,
	},

	-- Configuration for NvimTree
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

	-- Configuration to install and use "Harpoon"
	{
		"theprimeagen/harpoon",
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
		keys = {
			{
				"<leader>ah",
				function()
					require("harpoon"):list():add()
				end,
				desc = "harpoon file",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 4",
			},
			{
				"<leader>5",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "harpoon to file 5",
			},
		},
	},

	-- Configuration of "fzf"
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = "./install --bin",
			},
		},
		keys = {
			{ "<leader>ff", desc = "Search for files" },
			{ "<leader>fh", desc = "Search for files including hidden files" },
			{ "<leader>fg", desc = "Search within file contents" },
			{ "<leader>fd", desc = "List open buffers" },
		},
		config = function()
			-- Set FZF preview window options to "empty"
			vim.g.fzf_preview_window = {}

			-- Set float window options for a more square layout
			vim.cmd([[
	       let $FZF_DEFAULT_OPTS = '--height=30% --layout=reverse --border '
	           \ .. '--margin=0,20 ' " Horizontal margins
	           \ .. '--color=fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4,info:2,'
	           \ .. 'prompt:2,pointer:1,marker:5,spinner:4,header:3'
	       ]])

			-- Keyamps
			keymap.set(
				"n",
				"<leader>ff",
				":let $FZF_DEFAULT_COMMAND='rg --files --hidden "
					.. '--glob "!.git/" --glob "!venv/" --glob "!.*" '
					.. '--glob "!node_modules" --glob "!.DS_Store" '
					.. '--glob "!cmake-build-debug/" --glob "!lazy-lock.json"\' '
					.. "| Files<CR><CR>",
				{ desc = "Search for files" }
			)

			keymap.set(
				"n",
				"<leader>fh",
				":let $FZF_DEFAULT_COMMAND='' | Files<CR>",
				{ desc = "Search for files including hidden files" }
			)

			keymap.set("n", "<leader>fg", ":Rg<CR>", {
				desc = "Search within file contents",
			})

			keymap.set("n", "<leader>fd", ":Buffers<CR>", {
				desc = "List open buffers",
			})
		end,
	},

	{
		"folke/flash.nvim",
		keys = {
			{
				";",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
}

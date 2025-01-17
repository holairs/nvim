-- plugins/utilities.lua

-------------------------------------------------------------------------------
-------------------------------- UTILITIES ------------------------------------
-------------------------------------------------------------------------------
--                                                                           --
--  This configuration manages various plugins for enhancing the Neovim      --
--  experience, ranging from LSP features to file explorers, code formatting,--
--  Git integration, and more.                                               --
--                                                                           --
--  Features:                                                                --
--  1. Advanced file formatting using Conform for multiple languages.        --
--  2. Oil.nvim for an intuitive file explorer with floating window support. --
--  3. Telescope for efficient file searching, live grepping, and buffer     --
--     management.                                                           --
--  4. GitSigns for Git blame, diff, and hunk preview/reset functionalities. --
--  5. Undotree for local history management, allows to jump beetwen         --
--     undo tree changes.                                                    --
--  6. Harpoon for quick file navigation and project bookmarking with        --
--     customizable keybindings. Easily toggle a menu to manage marked files --
--     and switch between them with a single keypress.                       --
--  7. Treesitter for enhanced syntax highlighting, incremental selection,   --
--     and code indentation. Ensures better parsing for supported languages  --
--     like Lua, JavaScript, TypeScript, JSON, and Rust.                     --
--     Auto-installation of parsers keeps the setup up-to-date.              --
--                                                                           --
--  Key highlights:                                                          --
--  * Plugins are configured with custom key mappings for ease of use.       --
--  * Floating windows and minimal UI options to improve workflow.           --
--  * Lazy loading and conditional plugin activation for better performance. --
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local keymap = vim.keymap
local api = vim.api
local opt = vim.opt

return {

	-- Configuration of "Conform"
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
					gleam = { "gleam" },
				},
			})
		end,
	},

	-- Configuratio/ for "Oil.nvim" explorer
	{
		"stevearc/oil.nvim",
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

	-- Configuration for "Telescope"
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					preview = false,
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
							height = 0.7,
						},
					},
					file_ignore_patterns = { "node_modules", ".git" },
					hidden = true,
				},
			})
		end,
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({
						hidden = true,
					})
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Search Grep",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").colorscheme()
				end,
				desc = "Search colorscheme",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Open Buffers",
			},
		},
	},

	-- Configuration of "GitSigns"
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cond = function()
			return vim.fn.isdirectory(".git") == 1
		end,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = false, -- Enable git blame on line
			})
			keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			keymap.set("n", "<leader>gi", ":Gitsigns preview_hunk<CR>")
			keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", {
				noremap = true,
				silent = true,
			})
			keymap.set("v", "<leader>gr", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { noremap = true, silent = true }) -- Reset selected (v) hunks
		end,
	},

	-- Configuration for "undotree"
	{
		"mbbill/undotree",
		config = function()
			-- Enable persistent undo
			opt.undofile = true
			-- Directory where undo files will be saved
			opt.undodir = vim.fn.expand("~/.undotree")
			-- Create the directory if it doesn't exist
			-- Ensure the correct value is used as a string
			vim.fn.system({ "mkdir", "-p", opt.undodir._value })
			-- Mapping to open Undotree
			api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", {
				noremap = true,
				silent = true,
			})
		end,
	},

	-- Configuration of "Harpoon"
	{
		"theprimeagen/harpoon",
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

	-- Configuration of "treesitter"
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"javascript",
					"typescript",
					"json",
					"rust",
				},
				sync_install = false,
				auto_install = true,
				indent = {
					enable = true,
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}

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
--  1. Oil.nvim for an intuitive file explorer with floating window support. --
--  2. Telescope for efficient file searching, live grepping, and buffer     --
--     management.                                                           --
--  3. GitSigns for Git blame, diff, and hunk preview/reset functionalities. --
--  4. Fzf-Lua for grep searching and fuzzy file searching
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

return {

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

	-- Configuration for "fzf-lua"
	{
		"ibhagwan/fzf-lua",
		opts = {
			files = {
				previewer = false,
			},
			grep = {
				previewer = false,
			},
			buffers = {
				previewer = false,
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({
						hidden = true,
					})
				end,
				desc = "Find Files (including hidden)",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fc",
				function()
					require("fzf-lua").colorschemes()
				end,
				desc = "Search Colorscheme",
			},
			{
				"<leader>fd",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "Find Buffers",
			},
		},
	},
}

-- plugins/utilities.lua
-------------------------------------------------------------------------------
-------------------------------- UTILITIES ------------------------------------
-------------------------------------------------------------------------------
--                                                                           --
--  This configuration manages various plugins for enhancing the Neovim     --
--  experience, ranging from LSP features to file explorers, code formatting,--
--  Git integration, and more.                                               --
--                                                                           --
--  Features:                                                               --
--  1. Seamless integration of Copilot for AI-assisted code suggestions.    --
--  2. Advanced file formatting using Conform for multiple languages.       --
--  3. Oil.nvim for an intuitive file explorer with floating window support.--
--  4. Flash.nvim for quick navigation within files.                        --
--  5. Telescope for efficient file searching, live grepping, and buffer    --
--     management.                                                          --
--  6. GitLens for Git blame, diff, and hunk preview/reset functionalities. --
--                                                                           --
--  Key highlights:                                                         --
--  * Plugins are configured with custom key mappings for ease of use.      --
--  * Floating windows and minimal UI options to improve workflow.          --
--  * Lazy loading and conditional plugin activation for better performance.--
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local keymap = vim.keymap
local api = vim.api

return {

	-- Configuration for "Copilot"
	{
		"github/copilot.vim",
		config = function()
			-- Activar Copilot automáticamente
			vim.cmd("Copilot disable")
			-- Accept suggestions with Ctrl-F
			vim.api.nvim_set_keymap("i", "<C-f>", 'copilot#Accept("<CR>")', {
				silent = true,
				expr = true,
			})
			-- Navigate suggestions with Ctrl-N and Ctrl-P
			vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", {})
			vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", {})
			-- Toggle Copilot (enable/disable)
			local copilot_enabled = false -- Initial state
			function _G.toggle_copilot()
				if copilot_enabled then
					vim.cmd("Copilot disable")
					copilot_enabled = false
					print("Copilot disabled")
				else
					vim.cmd("Copilot enable")
					copilot_enabled = true
					print("Copilot enabled")
				end
			end
			vim.api.nvim_set_keymap("n", "<leader>cp", ":lua toggle_copilot()<CR>", {
				noremap = true,
				silent = true,
			})
		end,
	},

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

	-- Configuration for "Flash"
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

  -- Configuration for "Telescope"
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search Grep" })
			vim.keymap.set("n", "<leader>fd", builtin.buffers, { desc = "Open Buffers" })
			local fk_opts = {
				cwd = "~/.config/nvim",
				results_title = "Config",
			}
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files(fk_opts)
			end, { desc = "Search Config Files" })
		end,
	},

	-- Configuration of "GitLens"
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
}

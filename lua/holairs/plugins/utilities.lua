-- plugins/utilities.lua

---------------------------------------------------------------------------------------------------
-----------------------------------Utility Plugins for Neovim--------------------------------------
---------------------------------------------------------------------------------------------------
--
-- This file contains configurations for plugins that add various utility functionalities to Neovim:
--
-- 1. **gitsigns.nvim** - Adds git-related signs to the sign column, plus keybindings for navigation
--    and operations like blame, diff, and hunk reset. Only loads if in a git repository.
--
-- 2. **harpoon** - Allows quick navigation between files. You can mark files and switch between
--    them with customizable keybindings. This is the Harpoon 2 branch.
--
-- 3. **undotree** - Visualizes the undo history and allows navigation through different file states
--    with persistent undo enabled.
--
-- 4. **fzf.vim** - Integrates FZF (Fuzzy Finder) for searching files, contents, and more. Provides
--    keybindings for various search functionalities akin to advanced IDEs.
--
-- 5. **Flash** - Improves navigation through search results with an efficient one-key system
--    to jump to any match on the screen, making search and replace operations or simply
--    finding occurrences much faster and intuitive.
--
-- 6. **nvim-treesitter** - A parser generator tool and an incremental parsing library. It
--    provides syntax highlighting, indentation support, and enables features like text objects
--    for various programming languages, improving code readability and editor functionality.
--    Languages supported by default in this config include JavaScript, TypeScript, JSON, and Rust.
--
-- 7. **Conform** - Code - Language formatter tool, It provides syntax/code formatting using
--    external formatters like "prettier", "blac", etc.
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

return {

	-- Configuration of "gitsigns"
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cond = function()
			return vim.fn.isdirectory(".git") == 1
		end,
		config = function()
			require("gitsigns").setup({})
			vim.keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			vim.keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true }) -- Reset actual hunk
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true }) -- Reset all file
			vim.keymap.set("v", "<leader>ghr", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { noremap = true, silent = true }) -- Reset selected (v) hunks
		end,
	},

	-- Undotree configuration
	{
		"mbbill/undotree",
		config = function()
			-- Enable persistent undo
			vim.opt.undofile = true -- Enable the persistent undo system
			vim.opt.undodir = vim.fn.expand("~/.undotree") -- Directory where undo files will be saved

			-- Create the directory if it doesn't exist
			vim.fn.system({ "mkdir", "-p", vim.opt.undodir._value }) -- Ensure the correct value is used as a string

			-- Mapping to open Undotree
			vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true })
		end,
	},

	-- Configuration of "fzf" for navigating and searching for files, text, references,
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = "./install --bin",
			},
		},
		keys = {
			{ "<leader>ff", desc = "Buscar archivos" },
			{ "<leader>fg", desc = "Buscar en contenido de archivos" },
			{ "<leader>fs", desc = "Buscar archivos incluyendo ocultos" },
		},
		config = function()
			vim.g.fzf_preview_window = { "up:60%", "ctrl-/" } -- Preview to left

			-- Keyamps
			vim.keymap.set("n", "<leader>ff", ":Files<CR>", { desc = "Search for files" })
			vim.keymap.set("n", "<leader>fg", ":Rg<CR>", { desc = "Search within file contents" })
			vim.keymap.set("n", "<leader>fd", ":Buffers<CR>", { desc = "List open buffers" })
		end,
	},

	-- Configuration of "Flash"
	{
		"folke/flash.nvim",
		keys = {
			{
				"?",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
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

	-- Conform configuration
	{
		"stevearc/conform.nvim",
		keys = {
			{ "<leader>fa", ":lua require('conform').format({ async = true })<CR>", desc = "Formatear archivo" },
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
}

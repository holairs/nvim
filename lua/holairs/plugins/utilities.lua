-- plugins/utilities.lua

---------------------------------------------------------------------------------------------------
-----------------------------------Utility Plugins for Neovim--------------------------------------
--------------------------------------------------------------------------------------------------- This file contains configurations for plugins that add various utility functionalities to Neovim:
--
-- 1. **gitsigns.nvim** - Adds git-related signs to the sign column, plus keybindings for
--    navigation and operations like blame, diff, and hunk reset. Only loads if in a git repository.
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
--
-- 8. **aerial.nvim** - A code outline plugin for Neovim, which displays a sidebar with a
--    hierarchical view of symbols (functions, methods, classes, etc.) based on LSP, Treesitter,
--    or ctags. This provides a structured overview of the code, helping with navigation and
--    improving understanding of the file's layout. Configurable to display on either side of the
--    editor and offers integration with other Neovim features like LSP and Treesitter.
--
-- 9. **oil.nvim** - A file explorer and file manager for Neovim, providing an organized
--    interface for navigating and managing files and directories within the editor.
--
-- 10. **todo-comments.nvim** - A Neovim plugin that highlights and organizes TODO comments
--     in the code. It supports custom keywords, integrations with LocList and QuickFix, and
--     allows for quick navigation between TODOs. Ideal for tracking tasks, notes, or markers
--     in the codebase, enhancing productivity and organization during development.

-- 11. **zen-mode.nvim** - A Neovim plugin that provides a distraction-free coding environment
--     by centering and resizing the editor to a comfortable width, hiding unnecessary UI elements,
--     and optionally dimming background features. Perfect for focused coding sessions or writing.
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
				"<leader>a",
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
			{ "<leader>ff", desc = "Search for files" },
			{ "<leader>fh", desc = "Search for files including hidden files" },
			{ "<leader>fg", desc = "Search within file contents" },
			{ "<leader>fd", desc = "List open buffers" },
		},
		config = function()
			vim.g.fzf_preview_window = { "right:50%", "ctrl-/" } -- Preview on the right, taking 50%
			vim.cmd([[let $FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border' ]])
			vim.cmd(
				[[ let $FZF_DEFAULT_OPTS = '--height=50% --layout=reverse --border --color=fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4,info:2,prompt:2,pointer:1,marker:5,spinner:4,header:3' ]]
			)

			-- Keyamps
			vim.keymap.set(
				"n",
				"<leader>ff",
				':let $FZF_DEFAULT_COMMAND=\'rg --files --hidden --glob "!.git/" --glob "!venv/" --glob "!.*" --glob "!node_modules" --glob "!.DS_Store" --glob "!cmake-build-debug/" --glob "!lazy-lock.json"\' | Files<CR><CR>',
				{ desc = "Search for files" }
			)

			vim.keymap.set(
				"n",
				"<leader>fh",
				":let $FZF_DEFAULT_COMMAND='' | Files<CR>",
				{ desc = "Search for files including hidden files" }
			)
			vim.keymap.set("n", "<leader>fg", ":Rg<CR>", { desc = "Search within file contents" })
			vim.keymap.set("n", "<leader>fd", ":Buffers<CR>", { desc = "List open buffers" })
		end,
	},

	-- Configuration of "Flash"
	{
		"folke/flash.nvim",
		keys = {
			{
				"'",
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

	-- Configuration for Aerial.nvim
	{
		"stevearc/aerial.nvim",
		keys = {
			{
				"<leader>as",
				function()
					require("aerial").toggle()
				end,
				desc = "Toggle Aerial",
			},
		},
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "ctags" },
				layout = {
					default_direction = "left", -- to left
				},
			})
		end,
	},

	-- Configuration for "Oil.nvim" explorer
	{
		"stevearc/oil.nvim",
		keys = {
			{
				"<leader>ee",
				function()
					require("oil").open()
				end,
				desc = "Open Oil file explorer",
			},
		},
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
		},
		config = function()
			require("oil").setup()
		end,
	},
  -- Configuration for "todo-comments"

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		keys = {
			{
				"\\",
				function()
					vim.cmd("TodoQuickFix")
				end,
				desc = "Open Todo Quick Fix List",
			},
		},
		config = function()
			require("todo-comments").setup({})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "qf",
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
					vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
					vim.keymap.set("n", "<CR>", ":cclose<CR><CR>", opts)
				end,
			})
		end,
	},

	-- Configuration for "ZenMode" 
	{
		"folke/zen-mode.nvim",
		keys = {
			{
				"<leader>z",
				function()
					vim.cmd("ZenMode")
				end,
				desc = "Toggle Zenmode",
			},
		},
	},
}

-- plugins/utilities.lua

-------------------------------------------------------------------------------
--------------------------- Utility Plugins for Neovim ------------------------
-------------------------------------------------------------------------------
--
-- 1. **gitsigns.nvim** - Adds git-related signs to the sign column, plus
--    keybindings for navigation and operations like blame, diff, and reset.
--    Only loads if in a git repository.
--
-- 2. **undotree** - Visualizes the undo history and allows navigation through
--    different file states with persistent undo enabled.
--
-- 3. **fzf.vim** - Integrates FZF (Fuzzy Finder) for searching files, contents,
--    and more. Provides keybindings for various search functionalities akin to
--    advanced IDEs.
--
-- 4. **nvim-treesitter** - A parser generator tool and an incremental parsing
--    library. Provides syntax highlighting, indentation support, and enables
--    features like text objects for programming languages.
--
-- 5. **Conform** - Language formatter tool, supports external formatters like
--    "prettier" and "black" for efficient code formatting.
--
-- 6. **oil.nvim** - A file explorer and manager providing an organized
--    interface for navigating and managing files and directories within the
--    editor.
--
-- 7. **nvim-tree.lua** - A file explorer plugin that provides a tree view of
--     the project directory, allowing easy navigation and management of files
--     and directories within Neovim.
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Declare local variables
local keymap = vim.keymap
local opt = vim.opt
local api = vim.api

return {

	-- Configuration of "gitsigns"
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cond = function()
			return vim.fn.isdirectory(".git") == 1
		end,
		config = function()
			require("gitsigns").setup({
				current_line_blame = true, -- Enable git blame on line
			})
			keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", {
				noremap = true, -- Reset actual hunk
				silent = true,
			})
			keymap.set("n", "<leader>gr", ":Gitsigns reset_buffer<CR>", {
				noremap = true,
				silent = true,
			}) -- Reset all file
			keymap.set("v", "<leader>ghr", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { noremap = true, silent = true }) -- Reset selected (v) hunks
		end,
	},

	-- Configuration of "undotree"
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

	-- Configuration for "Conform"
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
				"<leader>er",
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
					border = "rounded", -- Options: "none", "single", "double", "rounded", etc.
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
				"<leader>ee",
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
				},
			})
			-- transparent background
			vim.cmd([[ highlight NvimTreeNormal guibg=NONE ctermbg=NONE ]])
		end,
	},
}

-- plugins/utilities.lua

-------------------------------------------------------------------------------
--------------------------- Utility Plugins for Neovim ------------------------
-------------------------------------------------------------------------------
-- 1. **gitsigns.nvim** - Adds git-related signs to the sign column, plus
--    keybindings for navigation and operations like blame, diff, and reset.
--    Only loads if in a git repository.
--
-- 2. **harpoon** - Allows quick navigation between files. You can mark files
--    and switch between them with customizable keybindings.
--
-- 3. **undotree** - Visualizes the undo history and allows navigation through
--    different file states with persistent undo enabled.
--
-- 4. **fzf.vim** - Integrates FZF (Fuzzy Finder) for searching files, contents,
--    and more. Provides keybindings for various search functionalities akin to
--    advanced IDEs.
--
-- 5. **Flash** - Improves navigation through search results with an efficient
--    one-key system to jump to any match on the screen, making search and
--    replace operations or simply finding occurrences much faster and intuitive.
--
-- 6. **nvim-treesitter** - A parser generator tool and an incremental parsing
--    library. Provides syntax highlighting, indentation support, and enables
--    features like text objects for programming languages.
--
-- 7. **Conform** - Language formatter tool, supports external formatters like
--    "prettier" and "black" for efficient code formatting.
--
-- 8. **aerial.nvim** - Displays a sidebar with a hierarchical view of symbols
--    (functions, methods, classes, etc.), improving navigation and
--    understanding of the file's layout.
--
-- 9. **oil.nvim** - A file explorer and manager providing an organized
--    interface for navigating and managing files and directories within the
--    editor.
--
-- 10. **copilot.vim** - Integrates GitHub Copilot into Neovim, providing
--     AI-assisted code completion and suggestions for faster and smarter
--     coding.
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
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
			vim.keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			vim.keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", {
				noremap = true, -- Reset actual hunk
				silent = true,
			})
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_buffer<CR>", {
				noremap = true,
				silent = true,
			}) -- Reset all file
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
			vim.opt.undofile = true
			-- Directory where undo files will be saved
			vim.opt.undodir = vim.fn.expand("~/.undotree")
			-- Create the directory if it doesn't exist
			-- Ensure the correct value is used as a string
			vim.fn.system({ "mkdir", "-p", vim.opt.undodir._value })

			-- Mapping to open Undotree
			vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", {
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
			-- Preview on the right, taking 50%
			vim.g.fzf_preview_window = { "right:50%", "ctrl-/" }
			vim.cmd([[
        let $FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border'
      ]])

			vim.cmd([[
        let $FZF_DEFAULT_OPTS = '--height=50% --layout=reverse --border '
          \ .. '--color=fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4,info:2,'
          \ .. 'prompt:2,pointer:1,marker:5,spinner:4,header:3'
      ]])

			-- Keyamps
			vim.keymap.set(
				"n",
				"<leader>ff",
				":let $FZF_DEFAULT_COMMAND='rg --files --hidden "
					.. '--glob "!.git/" --glob "!venv/" --glob "!.*" '
					.. '--glob "!node_modules" --glob "!.DS_Store" '
					.. '--glob "!cmake-build-debug/" --glob "!lazy-lock.json"\' '
					.. "| Files<CR><CR>",
				{ desc = "Search for files" }
			)

			vim.keymap.set(
				"n",
				"<leader>fh",
				":let $FZF_DEFAULT_COMMAND='' | Files<CR>",
				{ desc = "Search for files including hidden files" }
			)
			vim.keymap.set("n", "<leader>fg", ":Rg<CR>", {
				desc = "Search within file contents",
			})
			vim.keymap.set("n", "<leader>fd", ":Buffers<CR>", {
				desc = "List open buffers",
			})
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
			{
				"<leader>fa",
				":lua require('conform').format({ async = true })<CR>",
				desc = "Formatear archivo",
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
					default_direction = "right", -- to right
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
					local bufnr = vim.api.nvim_get_current_buf()
					local bufname = vim.api.nvim_buf_get_name(bufnr)

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
					max_width = 60,
					max_height = 20,
					border = "rounded", -- Options: "none", "single", "double", "rounded", etc.
					win_options = {
						winblend = 0, -- Transparency
					},
				},
			})
		end,
	},

	-- Configuration for "Copilot"
	{
		"github/copilot.vim",
		config = function()
			-- Activar Copilot automáticamente
			vim.cmd("Copilot enable")

			-- Accept suggestions with Ctrl-F
			vim.api.nvim_set_keymap("i", "<C-f>", 'copilot#Accept("<CR>")', {
				silent = true,
				expr = true,
			})

			-- Navigate suggestions with Ctrl-N and Ctrl-P
			vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", {})
			vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", {})

			-- Toggle Copilot (enable/disable)
			local copilot_enabled = true -- Initial state
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
}

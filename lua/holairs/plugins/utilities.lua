-- plugins/utilities.lua
local keymap = vim.keymap
local opt = vim.opt
local api = vim.api

return {

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

	-- Configuration for "snacks"
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true }, -- Big file support
			input = { enabled = true }, -- Nice UI for Floating input windows
			quickfile = { enabled = true }, -- Quick load file
			words = { enabled = true }, -- Highlight words under cursor
			lazygit = { enabled = true }, -- In Editor Lazygit integration
			zen = { enabled = true }, -- Zen mode
			statuscolumn = { enabled = true }, -- Git status in SignColumn
			animate = { enabled = true }, -- Animation
			indent = { enabled = true }, -- Indentation guides
		},
		keys = {
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
		},
	},

	-- Configuration for "Blink"(Completion plugin)
	-- {
	-- 	"saghen/blink.cmp",
	-- 	version = "*",
	--
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	--
	-- 	opts = {
	-- 		keymap = {
	-- 			preset = "default",
	-- 			["<C-p>"] = { "select_prev", "fallback" },
	-- 			["<C-n>"] = { "select_next", "fallback" },
	-- 			["<C-e>"] = {},
	-- 			["<CR>"] = { "select_and_accept", "fallback" },
	-- 		},
	-- 		appearance = {
	-- 			use_nvim_cmp_as_default = true,
	-- 			nerd_font_variant = "mono",
	-- 		},
	-- 		completion = {
	-- 			menu = {
	-- 				auto_show = function(ctx)
	-- 					return ctx.mode ~= "cmdline"
	-- 				end,
	-- 			},
	-- 		},
	--
	-- 		sources = {
	-- 			default = { "lsp", "path", "snippets", "buffer" },
	-- 		},
	-- 	},
	-- 	opts_extend = { "sources.default" },
	-- },
}

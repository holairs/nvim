return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
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
				current_line_blame = true, -- Enable git blame on line
			})
			vim.keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			vim.keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			vim.keymap.set("n", "<leader>gi", ":Gitsigns preview_hunk<CR>")
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", {
				noremap = true,
				silent = true,
			})
			vim.keymap.set("v", "<leader>gr", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { noremap = true, silent = true }) -- Reset selected (v) hunks
		end,
	},
}

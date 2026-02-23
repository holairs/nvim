return {
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
				current_line_blame = false,
			})
			vim.keymap.set("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>")
			vim.keymap.set("n", "<leader>df", ":Gitsigns diffthis<CR>")
			vim.keymap.set("n", "<leader>gi", ":Gitsigns preview_hunk<CR>")
			vim.keymap.set("n", "<leader>gh", ":Gitsigns reset_hunk<CR>", {
				noremap = true,
				silent = true,
			})
			vim.keymap.set("v", "<leader>gh", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { noremap = true, silent = true })
		end,
	},
}

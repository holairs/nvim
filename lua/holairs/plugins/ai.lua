-- plugins/ai.lua

-------------------------------------------------------------------------------
-----------------------------AI Plugins for Neovim ----------------------------
-------------------------------------------------------------------------------
--
-- 1. **copilot.vim** - Integrates GitHub Copilot into Neovim, providing
--     AI-assisted code completion and suggestions for faster and smarter
--     coding.
--
-- 2. **codecompanion.nvim** - A plugin that provides a floating window with
--     information about the current line, such as the function signature,
--     documentation, and more. It also supports markdown preview for better
--     documentation reading.
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return {

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

	-- Configuration for "codecompanion"
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- The following are optional to enable a nice markdown preview
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "markdown", "codecompanion" },
			},
		},
		keys = {
			{
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				desc = "Toggle Code Companion Chat",
			},
		},
		lazy = true,
		config = function()
			require("codecompanion").setup({})
		end,
	},
}

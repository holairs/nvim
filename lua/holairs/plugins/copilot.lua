return {
	-- Configuration for "Copilot"
	{
		"github/copilot.vim",
		event = "BufReadPost",
		config = function()

			-- Accept suggestions with Ctrl-F
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

			-- Toggle Copilot (enable/disable)
			vim.api.nvim_set_keymap("n", "<leader>cp", ":lua toggle_copilot()<CR>", {
				noremap = true,
				silent = true,
			})

			-- Accept suggestions with Ctrl-F
			vim.api.nvim_set_keymap("i", "<C-f>", 'copilot#Accept("<CR>")', {
				silent = true,
				expr = true,
			})

			-- Navigate suggestions with Ctrl-N and Ctrl-P
			vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", {})
			vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", {})
		end,
	}
}

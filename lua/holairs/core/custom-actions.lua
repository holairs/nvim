-- core/custom-actions.lua

local M = {}

-- Function to focus on a float window
function M.FocusFloat()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(wins) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
	print("No float window found")
end

-- Function to set transparency
local function set_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#303030" })
end

-- Function to toggle background theme
function M.ToggleTheme()
	if vim.o.background == "light" then
		vim.o.background = "dark"
		vim.cmd("colorscheme habamax")
	else
		vim.o.background = "light"
		vim.cmd("colorscheme default")
	end

	-- Reapply colorscheme if dark and light is available with the same name
	-- vim.cmd("colorscheme habamax")

	-- Apply transparency
	set_transparency()
end

-- Function to toggle line number display
function M.ToggleLineNumber()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
		vim.wo.number = true
	end
end

return M

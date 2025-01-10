-- core/custom-actions.lua

-------------------------------------------------------------------------------
-----------------------------Custom Neovim Actions ----------------------------
-------------------------------------------------------------------------------
--   This file contains custom actions for Neovim, including window focus,   --
--   theme toggling, line number display, and Quick Fix List enhancements.   --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local M = {}
local keymap = vim.keymap
local api = vim.api
local o = vim.o
local hl = vim.api.nvim_set_hl

-- Function to focus on a float window
function M.FocusFloat()
	local wins = api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(wins) do
		local config = api.nvim_win_get_config(win)
		if config.relative ~= "" then
			api.nvim_set_current_win(win)
			return
		end
	end
	print("No float window found")
end

-- Function to set transparency
local function set_transparency()
	hl(0, "Normal", { bg = "none" })
	hl(0, "NormalNC", { bg = "none" })
	hl(0, "NormalFloat", { bg = "none" })
	hl(0, "FloatBorder", { bg = "none" })
	hl(0, "EndOfBuffer", { bg = "none" })
	hl(0, "SignColumn", { bg = "none" })
	hl(0, "ColorColumn", { bg = "#303030" })
end

-- Function to toggle background theme
function M.ToggleTheme()
	if o.background == "light" then
		o.background = "dark"
	else
		o.background = "light"
	end

	-- Reapply colorscheme if dark and light is available with the same name
	vim.cmd("colorscheme habamax")

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

-- Function to force the correct way to use vim motions
function M.cowboy()
	---@type table?
	local ok = true
	for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
		local count = 0
		local timer = assert(vim.uv.new_timer())
		local map = key
		keymap.set("n", key, function()
			if vim.v.count > 0 then
				count = 0
			end
			if count >= 10 and vim.bo.buftype ~= "nofile" then
				ok = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
					icon = "💀",
					id = "cowboy",
					keep = function()
						return count >= 10
					end,
				})
				if not ok then
					return map
				end
			else
				count = count + 1
				timer:start(2000, 0, function()
					count = 0
				end)
				return map
			end
		end, { expr = true, silent = true })
	end
end

-- Reference preview in Quick Fix List
api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(event)
		local opts = { buffer = event.buf, silent = true }
		keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
		keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
		keymap.set("n", "<CR>", ":bdelete<CR>", opts)
	end,
})
return M

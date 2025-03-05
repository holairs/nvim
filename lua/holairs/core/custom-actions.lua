local M = {}
local keymap = vim.keymap
local api = vim.api
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

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

-- Reference preview in Quick Fix List
autocmd("FileType", {
	pattern = "qf",
	callback = function(event)
		local opts = { buffer = event.buf, silent = true }
		keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
		keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
		keymap.set("n", "<CR>", ":bdelete<CR>", opts)
	end,
})

-- Custom buffer tabs
function TabLine() -- Neds to be global instead of part or "M"
	local s = ""
	for tabnr = 1, vim.fn.tabpagenr("$") do
		-- Select the current tab
		local active = (tabnr == fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
		s = s .. active

		-- Active buffer name
		local buflist = fn.tabpagebuflist(tabnr)
		local winnr = fn.tabpagewinnr(tabnr)
		local bufname = fn.bufname(buflist[winnr])
		local filename = fn.fnamemodify(bufname, ":t") -- Get filename only
		local foldername = fn.fnamemodify(bufname, ":h:t")

		-- Show folder/filename or "[Blank]" if the filename is empty
		if filename ~= "" then
			s = s .. " " .. foldername .. "/" .. filename .. " "
		else
			s = s .. " [Blank] "
		end
	end

	s = s .. "%#TabLineFill#" -- Fill white space
	return s
end

return M

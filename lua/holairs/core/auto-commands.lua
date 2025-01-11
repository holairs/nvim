local autocmd = vim.api.nvim_create_autocmd
local wo = vim.wo
local w = vim.w
local opt_local = vim.opt_local

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.w.auto_cursorline then
			wo.cursorline = true
			vim.w.auto_cursorline = nil
		end
	end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		if wo.cursorline then
			w.auto_cursorline = true
			wo.cursorline = false
		end
	end,
})

-- Disable auto insert comment-line on insert mode defuault: "1jcroql"
autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		opt_local.formatoptions:remove("o")
	end,
})

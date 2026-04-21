-- core/auto-commands.lua

local autocmd = vim.api.nvim_create_autocmd
local wo = vim.wo
local w = vim.w
local opt_local = vim.opt_local
local augroup = vim.api.nvim_create_augroup

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

-- Resize splits with terminal window"
autocmd("VimResized", {
	group = augroup("EqualizeSplits", { clear = true }),
	callback = function()
		local current_tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		vim.api.nvim_set_current_tabpage(current_tab)
	end,
})

-- Auto CMP
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
-- 	callback = function(args)
-- 		local client_id = args.data.client_id
-- 		if not client_id then
-- 			return
-- 		end
--
-- 		local client = vim.lsp.get_client_by_id(client_id)
-- 		if client and client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client_id, args.buf, {
-- 				autotrigger = true, -- To auto launch CMP
-- 				autotrigger = false,
-- 			})
-- 		end
-- 	end,
-- }
-- )

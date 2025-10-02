-- core/custom-actions.lua

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
		-- keymap.set("n", "<CR>", ":bdelete<CR>", opts)
		keymap.set("n", "<CR>", "<CR> | <cmd>cclose<CR>", opts)
	end,
})

-- Code runnner in split terminal
local function CodeRunner(filetype, command)
	autocmd("FileType", {
		pattern = filetype,
		callback = function()
			keymap.set("n", "<leader>rr", ":w<CR>:split term://" .. command .. " %<CR>:resize 10<CR>", {
				buffer = true,
				desc = "Execute File",
				noremap = true,
				silent = true,
			})
		end,
	})
end

-- Define the commands for each filetype
CodeRunner("javascript", "bun")
CodeRunner("typescript", "bun")
CodeRunner("cpp", "g++ % -o %:r && ./%:r")
CodeRunner("python", "python3")
CodeRunner("rust", "cargo run")

-- Custom buffer tabs
function TabLine() -- Neds to be global instead of part or "M" local s = ""
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

-- Native FZF file search using fzf
-- Open a file fuzzy finder in a terminal split window, using fzf.
vim.api.nvim_create_user_command("FzfFind", function()
  vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
    split = "below",
  })
  vim.fn.jobstart({ "fzf", "--reverse" }, {
    on_exit = function()
      local fname = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
      vim.api.nvim_buf_delete(0, { force = true })
      if fname ~= "" then
        vim.cmd.edit(vim.fn.fnameescape(fname))
      end
    end,
    term = true,
  })
  vim.cmd.startinsert()
end, {})

-- Livegrepper.
-- Open a live grepper in a terminal split window, using fzf and ripgrep.
vim.api.nvim_create_user_command("FzfGrep", function()
  vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
    split = "below",
  })
  local rg = "rg -Suug !.git --column --color=always --"
  vim.fn.jobstart({
    "fzf",
    "--ansi",
    "--disabled",
    "--reverse",
    "--bind=change:reload:" .. rg .. " {q} || true",
  }, {
    env = { FZF_DEFAULT_COMMAND = rg .. " ''" },
    on_exit = function()
      local fname, line, col = vim.api
        .nvim_buf_get_lines(0, 0, 1, true)[1]
        :match("^(.+):(%d+):(%d+):.*$")
      vim.api.nvim_buf_delete(0, { force = true })
      if fname then
        vim.cmd.edit(vim.fn.fnameescape(fname))
        vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
      end
    end,
    term = true,
  })
  vim.cmd.startinsert()
end, {})

vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfFind<CR>")
vim.keymap.set("n", "<Leader>fg", "<Cmd>FzfGrep<CR>")

return M

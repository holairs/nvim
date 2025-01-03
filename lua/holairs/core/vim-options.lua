-- core/vim-options.lua
local opt = vim.opt
local g = vim.g
local api = vim.api
local o = vim.o
local command = api.nvim_create_user_command
local set_sign = vim.fn.sign_define
local cmd = vim.cmd

-- Encoding options
vim.scriptencoding = "utf-8"
vim.encoding = "utf-8"
vim.fileencoding = "utf-8"

-- Set the shell to fish
vim.opt.shell = "fish"

-- Map the space bar as the main command key
g.mapleader = " "

-- Guide column for 100 characters and chage color to march statusline
opt.colorcolumn = "80"

-- Global Clipboard
opt.clipboard = "unnamed"

-- Relative and numberline
opt.number = true
opt.relativenumber = true

-- Better term colors :0
opt.termguicolors = true

-- Set as "searching" the actual searh
opt.incsearch = true

-- Mark column for better LSP linting
opt.signcolumn = "yes"

-- Removes the highlight from searched text upon leaving the search
opt.hlsearch = false

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Some default settings
-- Sets the number of spaces a tab is displayed as
opt.tabstop = 2
-- Sets the number of spaces used for indentation steps
opt.shiftwidth = 2
-- Converts tabs to spaces
opt.expandtab = true
-- Automatically indents a new line the same amount as the line just typed
opt.autoindent = true
-- Does smart autoindenting when starting a new line (for C-like programming)
opt.smartindent = true
-- Enables more specific C-style indenting
opt.cindent = true
-- Disables line wrapping
opt.wrap = false
-- Changes the terminal's title to the name of the current file
opt.title = true
-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10
-- Ignore case in search patterns
opt.ignorecase = true
-- Preserve indentation in wrapped lines
opt.breakindent = true
-- Allows for recursive file searching in commands like `:find`
opt.path:append({ "**" })
-- Ignores node_modules directories when using file completion
opt.wildignore:append({ "*/node_modules/*" })
-- Disables creating backup files
opt.backup = false
-- Shows the effects of a command incrementally in a split window
opt.inccommand = "split"
-- Inserts blanks on a <Tab> key according to 'shiftwidth' or 'tabstop'
opt.smarttab = true
-- Allows backspacing over autoindent, line breaks, and start of insert
opt.backspace = { "start", "eol", "indent" }

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Adds 'i' to the list of formatoption flags,
-- which controls how Vim formats text.
-- Specifically, 'i' means 'auto-wrap text using textwidth'.
opt.formatoptions:append({ "i" })

o.showtabline = 1 -- Hide tabline when there is only one tab
o.tabline = "%!v:lua.TabLine()" -- Use lua function to generate tabline

function TabLine()
	local s = ""
	for tabnr = 1, vim.fn.tabpagenr("$") do
		-- Select the current tab
		local active = (tabnr == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
		s = s .. active

		-- Active buffer name
		local buflist = vim.fn.tabpagebuflist(tabnr)
		local winnr = vim.fn.tabpagewinnr(tabnr)
		local bufname = vim.fn.bufname(buflist[winnr])
		local filename = vim.fn.fnamemodify(bufname, ":t") -- Get filename only
		local foldername = vim.fn.fnamemodify(bufname, ":h:t")

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

-- Set cursorline
opt.cursorline = true

cmd([[
  augroup CustomCursorLine
    autocmd!
    autocmd ColorScheme * highlight CursorLine gui=underline ctermbg=NONE guibg=NONE 
    " Use or add "gui=underline" to set underline
  augroup END
]])

-- Cursor as "Block" but with "Blink" effect in insert mode
opt.guicursor = "n-v-c-sm:block,i-ci-ve:blinkon1"

-- Disable native mode line
opt.showmode = true

-- CommandLine use just 1 line
opt.cmdheight = 1

-- Create custom command for miskates :)
command("Q", "q", {})
command("W", "w", {})
command("Wq", "wq", {})
command("Wqa", "wqa", {})

-- Set default colorscheme
o.background = "dark"

-- Set Error diagnostic sign
set_sign("DiagnosticSignError", {
	text = ">>",
	texthl = "DiagnosticSignError",
	numhl = "",
})

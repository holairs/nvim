-- core/vim-options.lua

local opt = vim.opt
local g = vim.g
local api = vim.api

-- Encoding options
vim.scriptencoding = "utf-8"
vim.encoding = "utf-8"
vim.fileencoding = "utf-8"

-- Map the space bar as the main command key
g.mapleader = " "

-- Guide column (colorcolumn) for 100 characters and chage color to march statusline
opt.colorcolumn = "100"

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

-- Minimal Netrw explorer
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_liststyle = 0

-- Some default settings
opt.tabstop = 2 -- Sets the number of spaces a tab is displayed as
opt.shiftwidth = 2 -- Sets the number of spaces used for indentation steps
opt.expandtab = true -- Converts tabs to spaces
opt.autoindent = true -- Automatically indents a new line the same amount as the line just typed
opt.smartindent = true -- Does smart autoindenting when starting a new line (for C-like programming)
opt.cindent = true -- Enables more specific C-style indenting
opt.wrap = false -- Disables line wrapping
opt.title = true -- Changes the terminal's title to the name of the current file
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
opt.ignorecase = true -- Ignore case in search patterns
opt.breakindent = true -- Preserve indentation in wrapped lines
opt.path:append({ "**" }) -- Allows for recursive file searching in commands like `:find`
opt.wildignore:append({ "*/node_modules/*" }) -- Ignores node_modules directories when using file completion
opt.backup = false -- Disables creating backup files
opt.inccommand = "split" -- Shows the effects of a command incrementally in a split window
opt.smarttab = true -- Inserts blanks on a <Tab> key according to 'shiftwidth' or 'tabstop'
opt.backspace = { "start", "eol", "indent" } -- Allows backspacing over autoindent, line breaks, and start of insert

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Adds 'i' to the list of formatoption flags, which controls how Vim formats text.
-- Specifically, 'i' means 'auto-wrap text using textwidth'.
opt.formatoptions:append({ "i" })

-- Custom statusline
opt.statusline = "%f %m %r %=%-14.(%l,%c%V%) %P %y"

-- Set cursorline
opt.cursorline = true

vim.cmd([[
  augroup CustomCursorLine
    autocmd!
    autocmd ColorScheme * highlight CursorLine ctermbg=NONE guibg=NONE "Use "gui=underline" to set underline
  augroup END
]])

-- Cursor as "Block" but with "Blink" effect in insert mode
opt.guicursor = "n-v-c-sm:block,i-ci-ve:blinkon1"

-- CommandLine use just 1 line
opt.cmdheight = 1

-- Create custom command for :Q -> :q
api.nvim_create_user_command("Q", "q", {})

-- Create custom command for :W -> :w
api.nvim_create_user_command("W", "w", {})

-- Create custom command for :Wq -> :wq
api.nvim_create_user_command("Wq", "wq", {})

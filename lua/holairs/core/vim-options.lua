-- core/vim-options.lua

-------------------------------------------------------------------------------
---------------------------- Vim Options Configuration ------------------------
-------------------------------------------------------------------------------
--   This file defines custom options and settings for Neovim. It includes   --
--   encoding preferences, tab behavior, search settings, clipboard          --
--   integration, UI adjustments, and custom commands for convenience.       --
--   The configuration ensures a streamlined and optimized editing           --
--   experience tailored to modern development workflows.                    --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local opt = vim.opt
local g = vim.g
local api = vim.api
local o = vim.o
local command = api.nvim_create_user_command
local set_sign = vim.fn.sign_define

vim.o.completeopt = "menuone,noselect,noinsert"

-- Set persistent undo
opt.undofile = true

-- Encoding options
vim.scriptencoding = "utf-8"
vim.encoding = "utf-8"
vim.fileencoding = "utf-8"

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

opt.fillchars:append { vert = "|", horiz = "-" } -- Use a thin vertical bar as a separator

-- Set as "searching" the actual searh
opt.incsearch = true

-- Mark column for better LSP linting
opt.signcolumn = "yes"

-- Removes the highlight from searched text upon leaving the search
opt.hlsearch = false

-- Netrw tree view
g.netrw_banner = 0
g.netrw_liststyle = 0
g.netrw_altv = 1
g.netrw_winsize = 25
g.netrw_preview = 1
g.netrw_list_hide = 0

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Some default settings
-- Sets the number of spaces a tab is displayed as
opt.tabstop = 2
-- Sets the number of spaces used for indentation steps
opt.shiftwidth = 2
-- Converts tabs to spaces
opt.expandtab = false
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
opt.scrolloff = 8
opt.sidescroll = 1
opt.sidescrolloff = 8

-- No double space when Shift + J
opt.joinspaces = false

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
-- o.tabline = "%!v:lua.TabLine()" -- Use lua function to generate tabline

-- Set cursorline
opt.cursorline = true

-- Cursor as "Block" but with "Blink" effect in insert mode
opt.guicursor = "n-v-c-sm:block,i-ci-ve:blinkon1"
-- opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-CursorInsert-blinkon1,r-cr:block-Cursor"

-- Disable native mode line
opt.showmode = true

-- CommandLine use just 1 line
opt.cmdheight = 1

-- Disable Swap File
vim.opt.swapfile = false

-- Disable backup
vim.opt.backup = false

-- Disable unnecesary plugins
g.loaded_matchit = 1
g.loaded_man = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.osc52 = 1

-- Create custom command for miskates :)
command("Q", "q", {})
command("W", "w", {})
command("Wq", "wq", {})
command("Wqa", "wqa", {})

-- Set Error diagnostic sign
set_sign("DiagnosticSignError", {
	text = ">>",
	texthl = "DiagnosticSignError",
	numhl = "",
})

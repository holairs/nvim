-- core/keymaps.lua

-------------------------------------------------------------------------------
-------------------------- Key Mappings Configuration -------------------------
-------------------------------------------------------------------------------
--   This file defines custom key mappings for Neovim, enhancing usability   --
--   with actions like better paste, movement, LSP integration, and more.    --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local utils = require("holairs.core.custom-actions")
local keymap = vim.keymap -- for conciseness

-- Set action to use vim motions correctly 🗣️
utils.cowboy()

-- Better Paste in Visual-line mode
keymap.set("x", "<leader>p", '"_dP', {
	noremap = true,
	silent = true,
})

-- Move selections up / down
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection up(v)
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection down(v)

-- Move selection right / left
keymap.set("v", "<", "<gv", opts) -- move selection to the left
keymap.set("v", ">", ">gv", opts) -- move selection to the right

-- Delete but without saving the deleted data on clipboard
keymap.set({ "n", "v" }, "<leader>d", [["+y]])

-- Select a structured block (syntax)
keymap.set("n", "<leader>aa", "V$%") -- Replaced by treesitter

-- Make selection and fold of a structured code fragment
vim.keymap.set("n", "<leader>af", "zf%", { noremap = true, desc = "Fold current block" })

-- Remap to exit from terminal insert mode
vim.keymap.set("t", "||", "<C-\\><C-n>", {
	noremap = true,
	silent = true,
})

-- Open LSP suggestion menu
keymap.set("i", "<C-l>", "<C-x><C-o>")

-- Code Actions (LSP) for all language servers
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
	noremap = true,
	silent = true,
	desc = "Code Actions (LSP)",
})

-- Use CTRL + C as if it were "ESC"
-- to maintain consistency with LSP and other utilities ;)
keymap.set("n", "<C-c>", "<Esc>")
keymap.set("i", "<C-c>", "<Esc>")
keymap.set("v", "<C-c>", "<Esc>")
keymap.set("x", "<C-c>", "<Esc>")

-- Show actual file errors
keymap.set("n", "<leader>sel", "<cmd>lua vim.diagnostic.setqflist()<cr>", {
	noremap = true,
	silent = true,
})

-- Show diagnostic inline
keymap.set("n", "<leader>sd", vim.diagnostic.open_float, {
	noremap = true,
	silent = true,
})

-- Rename symbol (LSP)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
	buffer = bufnr,
	desc = "Rename symbol (LSP)",
})

-- Move between native tabs

-- Move to previous & next tabs
vim.keymap.set("n", "<", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", ">", ":tabnext<CR>", { noremap = true, silent = true })

-- Got to specific tab using numbers
keymap.set("n", "1p", "1gt")
keymap.set("n", "2p", "2gt")
keymap.set("n", "3p", "3gt")
keymap.set("n", "4p", "4gt")
keymap.set("n", "5p", "5gt")
keymap.set("n", "6p", "6gt")
keymap.set("n", "7p", "7gt")
keymap.set("n", "8p", "8gt")
keymap.set("n", "9p", "9gt")

-- Create a new tab
keymap.set("n", "<leader>np", ":tabnew<CR>")

-- Move actual tab to the left
vim.keymap.set("n", "<leader>tl", ":tabmove -1<CR>", { noremap = true, silent = true })

-- Move actual tab to the right
vim.keymap.set("n", "<leader>tr", ":tabmove +1<CR>", { noremap = true, silent = true })

-- Close actual tab
keymap.set("n", "<leader>qt", ":tabclose<CR>")

-- Quit buffer
keymap.set("n", "<leader>qq", ":q<CR>")

-- Move inside native nvvim panels
keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Split panes with native nvim
keymap.set("n", "<leader>o", ":sp<CR>")
keymap.set("n", "<leader>p", ":vsp<CR>")

-- Adjust panels size
keymap.set("n", "<C-p>", "10<C-w><")
keymap.set("n", "<C-o>", "10<C-w>>")
keymap.set("n", "<C-'>", "2<C-w>+")
keymap.set("n", "<C-;>", "2<C-w>-")

-- Increase and decrease numbers
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<leader>as", "gg<S-v>G")

-- Move between buffers
keymap.set("n", "<Tab>", ":bnext<CR>", {
	noremap = true,
	silent = true,
})
keymap.set("n", "<S-Tab>", ":bprevious<CR>", {
	noremap = true,
	silent = true,
})

-- Close actual buffer
keymap.set("n", "<leader>ww", ":bdelete<CR>", {
	noremap = true,
	silent = true,
})

-- Close other buffers
keymap.set("n", "<leader>we", ":%bdelete|edit#|bdelete#<CR>", {
	noremap = true,
	silent = true,
})

-- Surround words with symbols
keymap.set("x", "<leader>s'", [[:s/\%V\(.*\)\%V/'\1'/ <CR>]], {
	desc = "Surround selection with '",
})
keymap.set("x", '<leader>s"', [[:s/\%V\(.*\)\%V/"\1"/ <CR>]], {
	desc = 'Surround selection with "',
})
keymap.set("x", "<leader>s*", [[:s/\%V\(.*\)\%V/*\1*/ <CR>]], {
	desc = "Surround selection with *",
})
keymap.set("x", "<leader>s)", [[:s/\%V\(.*\)\%V/(\1)/ <CR>]], {
	desc = "Surround selection with ()",
})
keymap.set("x", "<leader>s}", [[:s/\%V\(.*\)\%V/{\1}/ <CR>]], {
	desc = "Surround selection with {}",
})
keymap.set("x", "<leader>s]", [[:s/\%V\(.*\)\%V/[\1]/ <CR>]], {
	desc = "Surround selection with []",
})
keymap.set("x", "<leader>s>", [[:s/\%V\(.*\)\%V/<\1>/ <CR>]], {
	desc = "Surround selection with <>",
})

-- Surround selection words with symbols
keymap.set("n", "<leader>s*", [[:s/\<<C-r><C-w>\>/*<C-r><C-w>\*/ <CR>]], {
	desc = "Surround word with *",
})
keymap.set("n", '<leader>s"', [[:s/\<<C-r><C-w>\>/"<C-r><C-w>\"/ <CR>]], {
	desc = 'Surround word with "',
})
keymap.set("n", "<leader>s'", [[:s/\<<C-r><C-w>\>/'<C-r><C-w>\'/ <CR>]], {
	desc = "Surround word with '",
})
keymap.set("n", "<leader>s)", [[:s/\<<C-r><C-w>\>/(<C-r><C-w>\)/ <CR>]], {
	desc = "Surround word with ()",
})
keymap.set("n", "<leader>s}", [[:s/\<<C-r><C-w>\>/{<C-r><C-w>\}/ <CR>]], {
	desc = "Surround word with {}",
})
keymap.set("n", "<leader>s]", [[:s/\<<C-r><C-w>\>/[<C-r><C-w>\]/ <CR>]], {
	desc = "Surround word with []",
})
keymap.set("n", "<leader>s>", [[:s/\<<C-r><C-w>\>/<<C-r><C-w>\>/ <CR>]], {
	desc = "Surround word with <>",
})

-- Keymap to toggle line numbers
vim.keymap.set("n", "<leader>cn", function()
	utils.ToggleLineNumber()
end, { noremap = true, silent = true })

-- Keymap to toggle background theme
vim.keymap.set("n", "<leader>cb", function()
	utils.ToggleTheme()
end, { noremap = true, silent = true })

-- Keymap to focus on a float window
vim.keymap.set("n", "<leader>jf", function()
	utils.FocusFloat()
end, { noremap = true, silent = true })

-- Keymap to zoom active window pane native nvim
vim.keymap.set("n", "<leader>zi", "<C-w>|<C-w>_", { noremap = true, silent = true })
-- Revert zoom active window pane native nvim
vim.keymap.set("n", "<leader>zo", "<C-w>=", { noremap = true, silent = true })

-- Open netrw in the current directory
keymap.set("n", "<leader>er", "<Cmd>23Lexplore! %:p:h<CR>", {
	desc = "Toggle Right-side netrw file explorer with 25 col width",
})

-- Highlight actual selected word
vim.keymap.set("n", "<leader>hh", function()
	vim.cmd("set hlsearch")
	vim.fn.matchadd("Search", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
end, { noremap = true, desc = "Highlight word under cursor" })

-- Clear highlight
vim.keymap.set("n", "<leader>hn", function()
	vim.cmd("nohlsearch") -- clear highlight
  vim.fn.clearmatches() -- Clear temp highlights
end, { noremap = true, silent = true, desc = "Clear highlight" })

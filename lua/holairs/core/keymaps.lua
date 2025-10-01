-- core/keymaps.lua

local utils = require("holairs.core.custom-actions")
local keymap = vim.keymap -- for conciseness

-- Better Paste in Visual-line mode
keymap.set("x", "<leader>p", '"_dP', {
	noremap = true,
	silent = true,
})

-- Move selections up / down
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection up(v)
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection down(v)

-- Move selection right / left
keymap.set("v", "<", "<gv") -- move selection to the left
keymap.set("v", ">", ">gv") -- move selection to the right

-- Delete but without saving the deleted data on clipboard
keymap.set({ "n", "v" }, "<leader>d", [["+y]])

-- Select a structured block (syntax)
keymap.set("n", "<leader>aa", "V$%") -- in normal mode
keymap.set("v", "<leader>aa", "$%") -- in visual mode

-- Make selection and fold of a structured code fragment
keymap.set("n", "<leader>af", "zf%", { noremap = true, desc = "Fold current block" })

-- Remap to exit from terminal insert mode
keymap.set("t", "||", "<C-\\><C-n>", {
	noremap = true,
	silent = true,
})

-- Open LSP suggestion menu
keymap.set("i", "<C-l>", "<C-x><C-o>")

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

-- Run Rust program
-- keymap.set("n", "<leader>rr", "<cmd>!cargo run<cr>", {
-- 	noremap = true,
-- 	silent = true,
-- })

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
keymap.set("n", "<", ":tabprevious<CR>", { noremap = true, silent = true })
keymap.set("n", ">", ":tabnext<CR>", { noremap = true, silent = true })

-- Create a new tab
keymap.set("n", "<leader>np", ":tabnew<CR>")

-- Move actual tab to the left
keymap.set("n", "<leader>tl", ":tabmove -1<CR>", { noremap = true, silent = true })

-- Move actual tab to the right
keymap.set("n", "<leader>tr", ":tabmove +1<CR>", { noremap = true, silent = true })

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

-- Keymap to focus on a float window
keymap.set("n", "<leader>jf", function()
	utils.FocusFloat()
end, { noremap = true, silent = true })

-- Keymap to zoom active window pane native nvim
keymap.set("n", "<leader>zi", "<C-w>|<C-w>_", { noremap = true, silent = true })

-- Revert zoom active window pane native nvim
keymap.set("n", "<leader>zo", "<C-w>=", { noremap = true, silent = true })

-- Highlight actual selected word
keymap.set("n", "<leader>jh", function()
	vim.cmd("set hlsearch")
	vim.fn.matchadd("Search", "\\<" .. vim.fn.expand("<cword>") .. "\\>")
end, { noremap = true, desc = "Highlight word under cursor" })

-- Clear highlight
keymap.set("n", "<leader>jn", function()
	vim.cmd("nohlsearch") -- clear highlight
	vim.fn.clearmatches() -- Clear temp highlights
end, { noremap = true, silent = true, desc = "Clear highlight" })

-- Better scroll
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Restart lsp
keymap.set("n", "<leader>rl", "<cmd>LspRestart<cr>")

-- Run format with Prettier
keymap.set("n", "<leader>fp", "<cmd>%!bun prettier --stdin-filepath %<cr>")

-- Run format with LSP
keymap.set("n", "<leader>fl", vim.lsp.buf.format)

-- Run format with CONFORM
keymap.set("n", "<leader>fa", function()
	require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end)

-- Replace actual word in the actual buffer
keymap.set("n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Better find Next and Previous
keymap.set("n", "n", "nzzzv", { noremap = true })
keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Better add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- LSP Actions
keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition (LSP)" })
keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Search references (LSP)" })
keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover docs (LSP)" })

-- Code Actions (LSP) for all language servers
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
	noremap = true,
	silent = true,
	desc = "Code Actions (LSP)",
})

-- Toggle between normal and relative line numbers
keymap.set({ "n", "v" }, "<leader>cn", function()
	local opt = vim.opt
	if opt.relativenumber:get() then
		opt.relativenumber = false
		opt.number = true
	else
		opt.relativenumber = true
		opt.number = true
	end
end, { noremap = true, silent = true, desc = "Toggle relative numbers" })

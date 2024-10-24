-- core/keymaps.lua

local keymap = vim.keymap -- for conciseness

-- Better Paste in Visual-line mode
keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true })

-- Select a structured block (syntax)
keymap.set("n", "<leader>aa", "V$%")

-- Make selection and fold of a structured code fragment (as if it were syntax-based)
keymap.set("n", "<leader>af", "V$%zf")

-- Open LSP suggestion menu
keymap.set("i", "<C-l>", "<C-x><C-o>")

-- Code Actions (LSP) for all language servers
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Actions (LSP)" })

-- Use CTRL + C as if it were "ESC" to maintain consistency with LSP and other utilities ;)
keymap.set("n", "<C-c>", "<Esc>")
keymap.set("i", "<C-c>", "<Esc>")
keymap.set("v", "<C-c>", "<Esc>")
keymap.set("x", "<C-c>", "<Esc>")

-- Show actual file errors
vim.api.nvim_set_keymap(
	"n",
	"<leader>sel",
	"<cmd>lua vim.diagnostic.setqflist()<cr>",
	{ noremap = true, silent = true }
)

-- Show diagnostic inline
keymap.set("n", "<leader>sd", vim.diagnostic.open_float, { noremap = true, silent = true })

-- Rename symbol (LSP)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol (LSP)" })

-- Move between native tabs

-- Move to previous & next tabs
keymap.set("n", "<leader>[", ":tabprevious<CR>")
keymap.set("n", "<leader>]", ":tabnext<CR>")

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

-- Close actual tab
keymap.set("n", "<leader>qq", ":tabclose<CR>")

-- Quit buffer
keymap.set("n", "<leader>ql", ":q<CR>")

-- Move inside native nvim panels
keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Show native explorer nvim
keymap.set("n", "<leader>ee", ":Ex<CR>")

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
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Move between buffers
keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

-- Close actual buffer
keymap.set("n", "<leader>ww", ":bdelete<CR>", { noremap = true, silent = true })

-- Close other buffers
keymap.set("n", "<leader>we", ":%bdelete|edit#|bdelete#<CR>", { noremap = true, silent = true })

-- Move selected lines in visual mode
keymap.set("v", "<leader>j", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap.set("v", "<leader>k", ":m '<-2<CR>gv=gv") -- move line down(v)

-- PYTHON TEMP: Replace "" with ''
keymap.set("n", "<leader>fp", ":%s/\"/'/g<CR>gg", { noremap = true, silent = true })

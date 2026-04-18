-- FILE: lua/holairs/core/plugin-keymaps.lua
-- PURPOSE: TODOS los keymaps de plugins
------------------------------------------------

local map = vim.keymap.set

-- =====================
-- OIL
-- =====================
-- FILE: lua/holairs/core/plugin-keymaps.lua
-- FIX: Oil toggle (open / close correctly)
------------------------------------------------

map("n", "<leader>ee", function()
  local oil = require("oil")
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  -- Si el buffer actual es Oil -> cerrar
  if bufname:match("^oil://") then
    oil.close()
  else
    -- Si no es Oil -> abrir flotante
    oil.open_float()
  end
end, { desc = "Toggle Oil floating explorer" })

-- =====================
-- SNACKS: Git
-- =====================
map("n", "<leader>gg", function()
  require("snacks").lazygit()
end, { desc = "Lazygit" })

map("n", "<leader>gb", function()
  require("snacks").git.blame_line()
end, { desc = "Git Blame Line" })

map("n", "<leader>gB", function()
  require("snacks").gitbrowse()
end, { desc = "Git Browse" })

map("n", "<leader>gf", function()
  require("snacks").lazygit.log_file()
end, { desc = "Lazygit File History" })

map("n", "<leader>gl", function()
  require("snacks").lazygit.log()
end, { desc = "Lazygit Log" })

-- =====================
-- SNACKS: Navigation
-- =====================
map({ "n", "t" }, "]]", function()
  require("snacks").words.jump(vim.v.count1)
end, { desc = "Next Reference" })

map({ "n", "t" }, "[[", function()
  require("snacks").words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- =====================
-- SNACKS: Pickers
-- =====================
map("n", "<leader>ff", function()
  require("snacks").picker.files()
end, { desc = "Find Files" })

map("n", "<leader>fg", function()
  require("snacks").picker.grep()
end, { desc = "Grep Files" })

map("n", "<leader>fd", function()
  require("snacks").picker.buffers()
end, { desc = "Find Buffers" })

map("n", "<leader>fc", function()
  require("snacks").picker.colorschemes()
end, { desc = "Colorschemes" })

map("n", "<leader>fr", function()
  require("snacks").picker.lsp_references()
end, { desc = "LSP References" })

map("n", "<leader>er", function()
  require("snacks").explorer.reveal()
end, { desc = "Explorer" })

-- =====================
-- SNACKS: UI
-- =====================
map("n", "<leader>zz", function()
  require("snacks").zen()
end, { desc = "Zen Mode" })

map("n", "<leader>zx", function()
  require("snacks").zen.zoom()
end, { desc = "Zoom" })

map({ "n", "t" }, "<C-/>", function()
  require("snacks").terminal()
end, { desc = "Toggle Terminal" })


-- =====================
-- CONFORM
-- =====================
vim.keymap.set({ "n", "v" }, "<leader>fa", function()
  require("conform").format({
    bufnr = vim.api.nvim_get_current_buf(),
    lsp_fallback = true,
  })
end, { desc = "Format buffer (Conform)" })

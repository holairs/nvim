-- lua/plugin-keymaps.lua

local map = vim.keymap.set

-- OIL
map("n", "<leader>ee", function()
  local oil = require("oil")
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  if bufname:match("^oil://") then
    oil.close()
  else
    oil.open_float()
  end
end, { desc = "Toggle Oil floating explorer" })

-- SNACKS 
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

map({ "n", "t" }, "]]", function()
  require("snacks").words.jump(vim.v.count1)
end, { desc = "Next Reference" })

map({ "n", "t" }, "[[", function()
  require("snacks").words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

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

map("n", "<leader>zz", function()
  require("snacks").zen()
end, { desc = "Zen Mode" })

map("n", "<leader>zx", function()
  require("snacks").zen.zoom()
end, { desc = "Zoom" })

map({ "n", "t" }, "<C-/>", function()
  require("snacks").terminal()
end, { desc = "Toggle Terminal" })


-- CONFORM
vim.keymap.set({ "n", "v" }, "<leader>fa", function()
  require("conform").format({
    bufnr = vim.api.nvim_get_current_buf(),
    lsp_fallback = true,
  })
end, { desc = "Format buffer (Conform)" })

-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua

return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  -- Reemplazamos 'opts' con 'config' para tener más control
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_lspconfig = require("mason-lspconfig")

    -- Definimos on_attach y capabilities aquí, ya que son necesarios para los handlers
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local on_attach = function(client, bufnr)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition (LSP)" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Search references (LSP)" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover docs (LSP)"}) -- Añadí este que es muy útil
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions (LSP)"}) -- Y este también
      vim.keymap.set("n", "<Leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
      end, { buffer = bufnr, desc = "Toggle Inlay Hints (LSP)" })
    end

    -- La configuración principal de mason-lspconfig
    mason_lspconfig.setup({
      -- Lista de servidores a instalar
      ensure_installed = {
        "vtsls",
        "lua_ls",
        "rust_analyzer",
        "jsonls",
        "basedpyright",
        "clangd",
      },
      -- Handlers para configurar cada servidor
      handlers = {
        -- El handler por defecto
        function(server_name)
          if server_name == "roslyn" then
            return -- Dejamos que 'roslyn.nvim' se encargue de este
          end

          local server_opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          -- Configuraciones personalizadas
          if server_name == "lua_ls" then
            server_opts.settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim", "require", "opts" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              },
            }
          end
          -- ... (puedes añadir otras personalizaciones aquí)

          lspconfig[server_name].setup(server_opts)
        end,
      },
    })
  end,
}

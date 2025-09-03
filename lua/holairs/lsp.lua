local function root_pattern(marker)
        return function()
                return vim.fs.root(0, marker)
        end
end

local servers = {
        -- Lua
        lua_ls = {
                name = "lua-language-server",
                cmd = { "lua-language-server" },
                _root_dir = root_pattern({ ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml",
                        "selene.toml", "selene.yml", ".git" }),
                filetypes = { "lua" },
        },
        -- Python
        basedpyright = {
                name = "basedpyright",
                cmd = { "basedpyright-langserver", "--stdio" },
                _root_dir = root_pattern({ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile",
                        "pyrightconfig.json", ".git" }),
                filetypes = { "python" },
                settings = {
                        python = {
                                analysis = {
                                        autoSearchPaths = true,
                                        diagnosticMode = "openFilesOnly",
                                        useLibraryCodeForTypes = true,
                                },
                        },
                }
        },
        -- Rust
        rust_analyzer = {
                name = "rust-analyzer",
                cmd = { "rust-analyzer" },
                _root_dir = root_pattern({ "Cargo.toml", ".git" }),
                filetypes = { "rust" },
        },
        -- TypeScript / JavaScript
        vtsls = {
                name = "vtsls",
                cmd = { "vtsls", "--stdio" },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
                _root_dir = root_pattern({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
        },
        -- C / C++
        cpp = {
                name = "clangd",
                cmd = { "clangd" },
                filetypes = { "cpp", "c" },
                root_dir = root_pattern({ ".git" }),
                init_options = {
                        fallbackFlags = {
                                "-std=c++11",
                        },
                },
        },
        -- C#
        omnisharp = {
                name = "omnisharp",
                cmd = { "omnisharp" },
                _root_dir = root_pattern({ ".sln", ".csproj", ".fsproj", ".vbp", ".suo", ".cs" }),
                filetypes = { "cs" },
                settings = {
                        ['omnisharp.json'] = {
                                EnableImportCompletion = true,
                        },
                },
        },
}

local group = vim.api.nvim_create_augroup("UserLspStart", { clear = true })
for _, config in pairs(servers) do
        if vim.fn.executable(config.cmd[1]) ~= 0 then
                vim.api.nvim_create_autocmd("FileType", {
                        group = group,
                        pattern = config.filetypes,
                        callback = function(ev)
                                if config._root_dir then
                                        config.root_dir = config._root_dir()
                                end
                                vim.lsp.start(config, { bufnr = ev.buf })
                        end,
                })
        end
end

-- Diagnostics style
vim.diagnostic.config({
        virtual_text = {
                spaces = 4,
                prefix = '●',
        },
        float = {
                source = true,
                border = 'rounded',
        },
        underline = false,
        update_in_insert = true,
})

-- LSP Keymaps
local set = vim.keymap.set
set('n', '<leader>e', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
set('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
set('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
set('i', '<C-S>', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
set("i", "<C-l>", "<C-x><C-o>")
set("n", "<leader>fa", vim.lsp.buf.format)

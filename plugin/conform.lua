-- FILE: plugin/conform.lua
-- PURPOSE: Lazy load de conform.nvim
------------------------------------------------

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/stevearc/conform.nvim",
		})

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "black" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				svelte = { "prettierd" },
				css = { "prettierd" },
				json = { "jq" },
				yaml = { "yq" },
				sh = { "shfmt" },
				cs = { "csharpier" },
				razor = { lsp_format = "fallback" },
			},
		})
	end,
})

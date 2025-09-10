return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
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
				-- Para archivos de C# (.cs)
				cs = { "csharpier" },

				-- Para archivos Razor (.razor, .cshtml)
				-- Se ejecutan en orden: primero csharpier, luego prettierd
				razor = { "csharpier", "prettierd" },
			},
		})
	end,
}

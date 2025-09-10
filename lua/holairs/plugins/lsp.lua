-- ~/.config/nvim/lua/plugins/lsp.lua

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim", -- La dependencia sigue siendo necesaria
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			cmp.setup({
				completion = {
					autocomplete = { cmp.TriggerEvent.TextChanged },
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-f>"] = cmp.mapping.scroll_docs(5),
					["<C-u>"] = cmp.mapping.scroll_docs(-5),
				},
				sources = {
					{ name = "nvim_lsp" },
				},
				window = {
					documentation = { winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder" },
					completion = { winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- Muestra el icono y el texto
						maxwidth = 50, -- Ancho máximo antes de cortar el texto
						ellipsis_char = "...", -- Carácter para el texto cortado
					}),
				},
				experimental = {
					ghost_text = false,
				},
			})
		end,
	},
}

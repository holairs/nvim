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
			-- Toda la lógica de setup de servidores se ha movido a 'mason-lspconfig.lua'
			-- Aquí solo queda la configuración de nvim-cmp

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
						-- Opciones adicionales por tipo de sugerencia (opcional)
						-- symbol_map = {
						-- 	Text = "󰉿",
						-- 	Method = "󰆧",
						-- 	Function = "󰊕",
						-- 	Constructor = "",
						-- 	Field = "󰜢",
						-- 	Variable = "󰀫",
						-- 	Class = "󰠃",
						-- 	Interface = "",
						-- 	Module = "",
						-- 	Property = "󰜢",
						-- 	Unit = "󰑭",
						-- 	Value = "󰎠",
						-- 	Enum = "",
						-- 	Keyword = "󰌋",
						-- 	Snippet = "",
						-- 	Color = "󰏘",
						-- 	File = "󰈙",
						-- 	Reference = "󰈇",
						-- 	Folder = "󰉋",
						-- 	EnumMember = "",
						-- 	Constant = "󰏿",
						-- 	Struct = "󰙅",
						-- 	Event = "",
						-- 	Operator = "󰆕",
						-- 	TypeParameter = "󰅲",
						-- },
					}),
				},
				experimental = {
					ghost_text = false,
				},
			})
		end,
	},

	-- La configuración de diagnósticos se mantiene igual
	vim.diagnostic.config({
		virtual_text = {
			spaces = 4,
			prefix = "●",
		},
		float = {
			source = true,
			border = "rounded",
		},
		underline = false,
		update_in_insert = true,
	}),
}

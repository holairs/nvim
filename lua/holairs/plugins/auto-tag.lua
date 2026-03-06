return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- Estas son las opciones que viste en el README
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		},
	},
}

-- ~/.config/nvim/lua/plugins/mason.lua

return {
	"williamboman/mason.nvim",
	opts = {
		registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		},
		ensure_installed = {
			"roslyn",
			"rzls",
		},
	},
}

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		-- Set header
		dashboard.section.header.val = {
			"                                     ",
			"                                     ",
			"                                     ",
			"                                ___     ",
			"      ___                      /\\  \\    ",
			"     /\\  \\        ___         |::\\  \\   ",
			"     \\:\\  \\      /\\__\\        |:|:\\  \\  ",
			"      \\:\\  \\    /:/__/      __|:|\\:\\  \\ ",
			"  ___  \\:\\__\\  /::\\  \\     /::::|_\\:\\__\\",
			" /\\  \\ |:|  |  \\/\\:\\  \\__  \\:\\~~\\  \\/__/",
			" \\:\\  \\|:|  |   ~~\\:\\/\\__\\  \\:\\  \\      ",
			"  \\:\\__|:|__|      \\::/  /   \\:\\  \\     ",
			"   \\::::/__/       /:/  /     \\:\\__\\    ",
			"    ~~~~           \\/__/       \\/__/    ",
			"                                     ",
			"                                     ",
		}
		-- Set menu
		dashboard.section.buttons.val = {}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}

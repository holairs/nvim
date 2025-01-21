-- nvim/lua/holairs/lazy.lua

-------------------------------------------------------------------------------
---------------------------- Lazy Plugin Manager ------------------------------
-------------------------------------------------------------------------------
--                                                                           --
--  This configuration bootstraps and sets up the "lazy.nvim" plugin manager --
--  for Neovim. It automatically clones the "lazy.nvim" repository if it     --
--  does not exist locally, ensuring a seamless initialization process.      --
--                                                                           --
--  Features:                                                               --
--  1. Imports the "holairs.plugins" module for plugin configuration.        --
--  2. Enables plugin updates with notifications disabled for a clean UI.   --
--  3. Provides change detection for plugin configurations without UI        --
--     interruptions.                                                       --
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "holairs.plugins" },
}, {
	ui = {
		icons = {
			cmd = " ",
			config = " ",
			event = " ",
			favorite = " ",
			ft = " ",
			init = " ",
			import = "↴ ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "● ",
			not_loaded = "○ ",
			plugin = "󰜫 ",
			runtime = " ",
			require = " ",
			source = " ",
			start = "▶ ",
			task = "✔ ",
			list = {
				"● ",
				"➜ ",
				"★ ",
				"‒ ",
			},
		},
	},
	lockfile = nil,
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

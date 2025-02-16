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
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "holairs.plugins" },
	},
	checker = { enabled = false },
})

-- nvim/init.lua

-------------------------------------------------------------------------------
---------------------------- Neovim Initialization ----------------------------
-------------------------------------------------------------------------------
--                                                                           --
--    This is the main entry point for configuring Neovim. It enables the    --
--    Neovim Lua loader, loads the core configurations, sets up the plugin   --
--    manager, and applies the custom "Nemesis" colorscheme and others       --
--    original colorschemes.                                                 --
--                                                                           --
--    Features:                                                              --
--    1. Enables the Lua loader for better performance.                      --
--    2. Loads core settings from "holairs.core".                            --
--    3. Sets up plugins via the "lazy.nvim" plugin manager.                 --
--    4. Applies the custom "Nemesis" colorscheme for a personalized look.   --
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

vim.loader.enable()

require("holairs.core")
require("holairs.lazy")

-- Set personal colorscheme
-- require("holairs.core.colorschemes.nemesis").setup()
require("holairs.core.colorschemes.monochrome").setup()
-- require("holairs.core.colorschemes.monochrome_light").setup()
-- require("holairs.core.colorschemes.blossom")
-- require("holairs.core.colorschemes.nocturne")

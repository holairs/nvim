-- lua/holairs/core/init.lua

-------------------------------------------------------------------------------
----------------------------- Core Configuration ------------------------------
-------------------------------------------------------------------------------
--  This file initializes the core modules for Neovim, including the        --
--  Nemesis colorscheme, Vim options, key mappings, and custom statusline.  --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require("holairs.core.nemesis")
require("holairs.core.vim-options")
require("holairs.core.keymaps")
require("holairs.core.statusline")
require("holairs.core.auto-commands")

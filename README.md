# Neovim Configuration - Holairs

This is my customized Neovim configuration, designed to be lightweight and efficient by avoiding unnecessary plugins and fully leveraging Neovim's native capabilities. This setup is ideal for those seeking a fast, minimalist experience, with specific tweaks to key mappings, LSP integration, and a carefully curated selection of plugins.

<img width="1728" alt="image" src="https://github.com/user-attachments/assets/b35f1827-8b26-4594-9617-901e5f587236">


## Purpose

The goal of this configuration is to maintain a lightweight Neovim setup, avoiding redundant plugins and manually configuring Neovim's built-in options and functionalities. I prefer a clean experience with minimal dependencies, where plugins are used only when they provide unique or otherwise challenging-to-replicate functionality.

## Key Features

### Neovim Options

The options are optimized for an enhanced Neovim experience:

- **Color Support:** `termguicolors` is enabled for a better visual experience, allowing Neovim to use the full range of colors supported by the terminal.
  
- **Consistent Indentation:** Configured to use spaces instead of tabs with `tabstop` and `shiftwidth` both set to `2`, providing consistent indentation across different environments and improving code readability.
  
- **Optimized Splits and Panels:** Native options are used to organize windows more comfortably:
  - `splitbelow` and `splitright` are enabled so that new horizontal splits open below and vertical splits open to the right, creating a more intuitive window layout.
  
- **Efficient Scrolling and Search:** 
  - `scrolloff` is set to `10`, keeping the cursor away from the screen's edges for better context while scrolling.
  - `ignorecase` and `incsearch` are enabled, allowing case-insensitive search by default and showing incremental search results in real-time.
  
- **Sign Column for Linting and Diagnostics:** 
  - `signcolumn` is always shown with `opt.signcolumn = "yes"`, reserving space for linting and diagnostic signs without shifting text.
  
- **And many others :D...**


### Custom Key Mappings

Key mappings are tailored for efficient navigation and a smooth workflow:

- **LSP key mappings:** Using Neovim's native functions without additional plugins for completion, renaming, and managing diagnostics.
- **Buffer and panel management:** Dedicated key mappings for switching between buffers, panels, and tabs.
- **Visual conveniences:** Keymaps for non-overwriting paste, selecting and folding structured code blocks, and quickly adjusting panel size.

### Minimal LSP Integration Without CMP Plugins

The LSP configuration is minimal, avoiding unnecessary plugins for autocompletion. Instead, Neovim provides basic autocompletion through `omnifunc`, and I use specific key mappings (`<C-l>`) to trigger LSP suggestions when needed. Additionally:

- **Quick Fix List for references and errors:** Errors and references are displayed in the Quick Fix List, accessible without requiring extra plugins.
- **Manual LSP server configuration:** Currently, the setup includes `rust_analyzer`, `ts_ls`, `lua_ls`, `pyright`, and `clangd`.

### Plugin Selection

The plugins chosen focus on adding valuable functionality that complements Neovim without cluttering the experience:
- **Total Plugins: ** 

- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim):** Displays git-related signs in the sign column and provides keybindings for navigating diffs and operations like blame and hunk reset.
- **[Harpoon](https://github.com/theprimeagen/harpoon):** Allows quick file navigation with a simple, customizable interface.
- **[undotree](https://github.com/mbbill/undotree):** Visualizes the undo history, making it easy to navigate different file states.
- **[fzf.vim](https://github.com/junegunn/fzf.vim):** Integrates FZF (Fuzzy Finder) for file, content search, and more, with keymaps for quick access.
- **[Flash.nvim](https://github.com/folke/flash.nvim):** Enhances search navigation with a single-key system for jumping to matches.
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** Provides syntax highlighting and support for advanced text manipulation in multiple languages.
- **[Conform](https://github.com/stevearc/conform.nvim):** A code formatting tool that uses external formatters like `prettier` and `black`.
- **[oil.nvim](https://github.com/stevearc/oil.nvim):** A file manager and explorer for Neovim, offering an organized interface.
- **[aerial.nvim](https://github.com/stevearc/aerial.nvim):** Displays a hierarchical view of code symbols, such as functions and classes, to help with navigation.

### Colorscheme

This configuration includes a default built-in colorscheme selected called "habamax" it can be modified inside "core/vim-options.lua"

## Project Structure

The configuration is divided into multiple files for better organization:

- **`init.lua`**: Loads base configurations and plugins.
- **`core/keymaps.lua`**: Contains custom key mappings.
- **`core/vim-options.lua`**: Configuration of global Neovim options.
- **`plugins/lsp/lsp.lua`**: Manual configuration of LSP servers for each language.
- **`plugins/colorscheme.lua`**: Manages colorschemes and custom color settings.
- **`plugins/utilities.lua`**: Configuration of utility plugins for Neovim.

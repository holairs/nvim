# Neovim Configuration

## Overview
Welcome to my Neovim configuration repository! This setup is tailored for efficient and enjoyable development workflows. It is structured in a modular way, focusing on performance, simplicity, and modern features.

### Features
- **Lazy Loading**: Plugins are loaded only when needed for faster startup.
- **Custom Colorschemes**: Includes `Monochrome` and `Nemesis` for visually appealing coding sessions.
- **LSP Integration**: Full Language Server Protocol (LSP) support for rich language features.
- **Git Integration**: Seamless Git integration with `gitsigns.nvim`.
- **Enhanced Navigation**: Tools like `harpoon.nvim` for quick file access and navigation.
- **Syntax Highlighting**: Advanced syntax highlighting with `nvim-treesitter`.
- **File Explorer**: Floating file explorer using `oil.nvim`.
- **Undo History**: Persistent undo history with `undotree`.

---

## Structure
The configuration is organized for readability and maintainability:

```
~/.config/nvim
├── init.lua
└── lua
    └── holairs
        ├── core
        │   ├── auto-commands.lua
        │   ├── colorschemes
        │   │   ├── monochrome.lua
        │   │   └── nemesis.lua
        │   ├── custom-actions.lua
        │   ├── init.lua
        │   ├── keymaps.lua
        │   ├── statusline.lua
        │   └── vim-options.lua
        ├── lazy.lua
        └── plugins
            ├── lsp.lua
            └── utilities.lua
```

### Key Components
1. **`init.lua`**: Entry point for Neovim configuration. Sets up the Lua loader, core modules, plugins, and colorscheme.
2. **Core Configuration (`lua/holairs/core`)**:
   - **`vim-options.lua`**: Optimized Vim options for modern workflows.
   - **`keymaps.lua`**: Custom key mappings for enhanced usability.
   - **`statusline.lua`**: Dynamic statusline configuration.
   - **`auto-commands.lua`**: Custom autocommands for dynamic behavior.
   - **Colorschemes**:
     - **`monochrome.lua`**: A minimal grayscale theme.
     - **`nemesis.lua`**: Inspired by Isaac Asimov's "Nemesis."
3. **Plugins (`lua/holairs/plugins`)**:
   - **`lsp.lua`**: LSP and autocompletion configuration.
   - **`utilities.lua`**: General utilities like file explorers, Git integrations, etc.

---

## Notable Plugins

### 1. [Lazy.nvim](https://github.com/folke/lazy.nvim)
Plugin manager for lazy loading and fast startup.

### 2. [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
Advanced syntax highlighting and incremental selection.

### 3. [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)
Quick navigation and bookmarking within projects.

### 4. [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
Git diff signs, blame annotations, and hunk previews.

### 5. [oil.nvim](https://github.com/stevearc/oil.nvim)
Minimalistic floating file explorer.

### 6. [undotree](https://github.com/mbbill/undotree)
Undo tree visualizer for navigating undo history.

---

## Customization

### Key Mappings
Custom key bindings improve workflow efficiency:
- **Navigation**:
  - `<C-h/j/k/l>`: Move between panes.
  - `<Tab>`/`<S-Tab>`: Cycle through buffers.
- **LSP Actions**:
  - `<leader>rn`: Rename symbol.
  - `<leader>ca`: Code actions.
- **Utilities**:
  - `<leader>u`: Toggle `undotree`.
  - `<leader>ah`: Add file to `harpoon`.
  - `<leader>h`: Toggle `harpoon` menu.

### Colorschemes
Choose between `monochrome` or `nemesis`. Activate via:
```lua
require("holairs.core.colorschemes.monochrome").setup()
-- or
require("holairs.core.colorschemes.nemesis").setup()
```

---

## Getting Started
1. Clone this repository into your Neovim config directory:
   ```bash
   git clone <repo-url> ~/.config/nvim
   ```
2. Open Neovim and run `:Lazy` to install plugins.
3. Start coding with a beautiful and functional setup!

---

## Contributions
Feel free to submit issues or pull requests to improve this configuration. Let's build a better development experience together!



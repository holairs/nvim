# Neovim Configuration

Welcome to my Neovim configuration repository! This setup is tailored for efficient and enjoyable development workflows. It is structured in a modular way, focusing on performance, simplicity, and modern features.

<img width="1728" alt="Screenshot 2025-01-22 at 11 35 50 AM" src="https://github.com/user-attachments/assets/c2df675e-1159-4422-9191-df6c13029f74" />
<img width="1728" alt="Screenshot 2025-01-22 at 11 31 21 AM" src="https://github.com/user-attachments/assets/22c0099c-1cea-471d-b1d1-a72bcaafe41a" />
<img width="1728" alt="Screenshot 2025-01-22 at 11 32 52 AM" src="https://github.com/user-attachments/assets/b22f2cd7-6714-4eb9-acfc-989a54517a7d" />


### Features
- **Lazy Loading**: Plugins are loaded only when needed for faster startup.
- **Custom Colorschemes**: Includes `Monochrome` and `Nemesis` for visually appealing coding sessions.
- **LSP Integration**: Full Language Server Protocol (LSP) support for rich language features.
- **Git Integration**: Seamless Git integration with `gitsigns.nvim`.
- **File Explorer**: Floating file explorer using `oil.nvim`.

---

## Structure
The configuration is organized for readability and maintainability:

```
~/.config/nvim
├── README.md
├── init.lua
└── lua
    └── holairs
        ├── core
        │   ├── auto-commands.lua
        │   ├── colorschemes
        │   │   ├── blossom.lua
        │   │   ├── monochrome.lua
        │   │   ├── monochrome_light.lua
        │   │   └── nemesis.lua
        │   ├── custom-actions.lua
        │   ├── init.lua
        │   ├── keymaps.lua
        │   └── vim-options.lua
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
     - **`blossom.lua`**: Inspired by flowers and retro colors."
     - **`monochrome.lua`**: Inspired vim-256noir colorscheme but improved por neovim"
     - **`monochrome_light.lua`**: Light version of monochrome colorscheme"
3. **Plugins (`lua/holairs/plugins`)**:
   - **`lsp.lua`**: LSP and autocompletion configuration.
   - **`utilities.lua`**: General utilities like file explorers, Git integrations, etc.

---

## Notable Plugins

### 1. [Lazy.nvim](https://github.com/folke/lazy.nvim)
Plugin manager for lazy loading and fast startup.

### 2. [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
Git diff signs, blame annotations, and hunk previews.

### 3. [oil.nvim](https://github.com/stevearc/oil.nvim)
Minimalistic floating file explorer.

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
  - `<leader>gd`: Go Definition.
  - `<leader>gr`: Go Reference.
- **Utilities**:
  - `<leader>ff`: Toggle `FZF-Lua`.
  - `<leader>ee`: Toggle `Oil`.
  - `<leader>df`: Toggle `Gitsigns Difference` view.

### Colorschemes
Choose between `monochrome`, `nemesis` or `blossom`. Activate via:
```lua
require("holairs.core.colorschemes.monochrome").setup()
--
require("holairs.core.colorschemes.nemesis").setup()
-- or
require("holairs.core.colorschemes.blossom")

```

---

## Getting Started
1. Clone this repository into your Neovim config directory:
   ```bash
   git clone https://github.com/holairs/nvim.git ~/.config/nvim
   ```
2. Open Neovim and run `:Lazy` to install plugins.
3. Start coding with a beautiful and functional setup!

---

## Contributions
Feel free to submit issues or pull requests to improve this configuration. Let's build a better development experience together!



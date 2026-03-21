# Wanto's Neovim Configuration

A modern, fast, and feature-rich Neovim configuration built with Lua, focusing on web development (Laravel, Vue, Angular, TypeScript) and a polished UI experience.

## ✨ Features

- 🚀 **Plugin Management**: Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) for fast startup and easy management.
- 🎨 **Aesthetic UI**: 
  - [Catppuccin Mocha](https://github.com/catppuccin/nvim) theme with custom overrides.
  - Custom [Lualine](https://github.com/nvim-lualine/lualine.nvim) with dynamic mode colors, LSP status, Copilot integration, and network monitoring.
  - [Bufferline](https://github.com/akinsho/bufferline.nvim) for elegant tab management.
  - [Noice.nvim](https://github.com/folke/noice.nvim) & [Nvim-notify](https://github.com/rcarriga/nvim-notify) for a modern command line and notification system.
  - [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) as a sidebar file explorer.
- 🛠️ **LSP & Completion**:
  - [blink.cmp](https://github.com/Saghen/blink.cmp): High-performance completion engine.
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with automatic server installation via [Mason](https://github.com/williamboman/mason.nvim).
  - Specialized support for **Laravel**, **Python (Venv)**, and **Frontend** frameworks.
- 🔍 **Powerful Search**: [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) with extensions for projects, undo history, git history, and more.
- 📝 **Editing Enhancements**:
  - [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for superior syntax highlighting.
  - [Conform.nvim](https://github.com/stevearc/conform.nvim) for lightning-fast formatting.
  - [Mini.nvim](https://github.com/echasnovski/mini.nvim) modules for icons, pairs, diff, and buffer removal.
  - [Markview.nvim](https://github.com/OXY2DEV/markview.nvim) for beautiful Markdown previewing.
- 🎮 **Extras**:
  - [Cord.nvim](https://github.com/vyfor/cord.nvim) for Discord Rich Presence.
  - [Toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) for integrated terminal management.
  - [Laravel.nvim](https://github.com/adalessa/laravel.nvim) for a first-class Laravel development experience.

## ⌨️ Key Mappings

The `<leader>` key is set to `Space` (default).

### 🔍 Search (Telescope)
| Key | Description |
|---|---|
| `<leader>sf` | Find Files |
| `<leader>sF` | Find All Files (including hidden) |
| `<leader>sg` | Live Grep |
| `<leader>sd` | Diagnostics |
| `<leader>sp` | Projects |
| `<leader>su` | Undo Tree |
| `<leader>sr` | Recent Files |
| `<leader>sh` | Help Tags |

### 📂 Explorer & UI
| Key | Description |
|---|---|
| `<leader>e` | Toggle Neo-tree |
| `<leader>tt` | Toggle Terminal |
| `<C-t>` | Open Context Menu (NVZone Menu) |
| `<leader>xx` | Toggle Trouble (Diagnostics) |

### 🛠️ LSP & Editing
| Key | Description |
|---|---|
| `<leader>rn` | Incremental Rename |
| `<leader>f` | Format Buffer |
| `<leader>q` | Open Diagnostic Quickfix |
| `<C-s>` | Save File |
| `[b` / `]b` | Previous / Next Buffer |
| `<leader>bd` | Delete Buffer |

### 🚀 Laravel & Python
| Key | Description |
|---|---|
| `<leader>ll` | Laravel Picker |
| `<leader>la` | Artisan Picker |
| `,v` | Venv Selector (Python) |

## 🚀 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wanto-production/nvim-config.git ~/.config/nvim
   ```

2. **Open Neovim**:
   ```bash
   nvim
   ```
   *Lazy.nvim will automatically download and install all plugins.*

3. **Install Language Servers**:
   Most servers are handled by `mason-tool-installer`, but you can manually manage them via `:Mason`.

## 📁 Structure

```text
~/.config/nvim
├── init.lua              # Entry point
└── lua/wanto/
    ├── core/             # Options, Keymaps, API
    ├── plugins/          # Plugin specifications (UI, Editor, LSP, etc.)
    ├── lazy.lua          # Lazy.nvim configuration
    └── lsp.lua           # LSP server configurations
```

---
Built with ❤️ by [Wanto](https://github.com/wanto-production)

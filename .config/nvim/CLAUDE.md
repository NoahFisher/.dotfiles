# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a personal Neovim configuration using Lua, organized as follows:

```
├── init.lua                 # Entry point that requires noah module
├── lua/noah/               # Main configuration module
│   ├── init.lua            # Loads packer, settings, and remaps
│   ├── packer.lua          # Plugin management with packer.nvim
│   ├── set.lua             # Core vim settings and options
│   ├── remap.lua           # Basic key remappings
│   └── keymap.lua          # Utility functions for creating keymaps
├── after/plugin/           # Plugin-specific configurations (loaded after plugins)
│   ├── lsp.lua             # LSP configuration using lsp-zero
│   ├── telescope.lua       # Telescope fuzzy finder keybindings
│   ├── harpoon.lua         # Harpoon file navigation
│   ├── treesitter.lua      # Treesitter syntax highlighting
│   ├── colors.lua          # Colorscheme setup (gruvbox)
│   ├── nerdtree.lua        # NERDTree file explorer settings
│   ├── tmux.lua            # Tmux integration
│   └── init.lua            # Additional plugin initializations
└── plugin/                 # Auto-generated packer files
    └── packer_compiled.lua
```

## Key Configuration Patterns

### Plugin Management
- Uses `packer.nvim` for plugin management
- Plugin configurations are split between `lua/noah/packer.lua` (plugin declarations) and `after/plugin/` (configurations)
- Run `:PackerSync` to update plugins

### Keymap System
- Custom keymap utility functions in `lua/noah/keymap.lua` provide `nnoremap`, `vnoremap`, etc.
- Leader key is set to space (`<Space>`)
- Local leader is backslash (`\`)

### LSP Configuration
- Uses `lsp-zero.nvim` preset for simplified LSP setup
- LSP keybindings are defined in `after/plugin/lsp.lua:41-54`
- Key LSP bindings: `gd` (definition), `K` (hover), `<leader>vca` (code actions), `<leader>vrn` (rename)

### Core Settings
- 2-space indentation for all files
- Line numbers with relative numbering enabled
- System clipboard integration (`clipboard = "unnamedplus"`)
- Persistent undo with `undofile = true`
- Color column at 120 characters

### Important Keybindings
- `<leader>a` - Telescope find_files
- `<leader>t` - Telescope git_files
- `<leader>gg` - Telescope live_grep
- `<leader>k` - Grep word under cursor
- `<leader>h` - Harpoon add file
- `<C-e>` - Harpoon toggle menu
- `<C-7,8,9,0>` - Harpoon navigate to files 1-4
- `J/K` in visual mode - Move selected lines up/down

## Development Workflow

### Making Configuration Changes
1. Edit files in `lua/noah/` for core settings
2. Edit files in `after/plugin/` for plugin-specific configurations
3. Restart Neovim or `:source %` to apply changes
4. Use `:PackerSync` after modifying plugin declarations

### Plugin Configuration
- Plugin declarations go in `lua/noah/packer.lua`
- Plugin configurations go in separate files under `after/plugin/`
- This separation follows Neovim best practices for plugin loading order

### Language Support
Configured for: JavaScript/TypeScript, Rust, Ruby, Go, Lua, C
- LSP support via lsp-zero
- Treesitter for syntax highlighting
- Language-specific plugins (vim-go, vim-ruby, etc.)
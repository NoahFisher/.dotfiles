# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration using Lua, organized as a dotfiles repository with symlinks to ~/.config/nvim. The configuration uses lazy.nvim as the plugin manager and emphasizes productivity features for Ruby/Rails development with integration for tmux, testing, and modern development tools.

## Key Architecture

### Core Structure
- `init.lua` - Entry point that loads the `noah` module
- `lua/noah/` - Main configuration directory
  - `lazy.lua` - Plugin definitions and management with lazy.nvim
  - `set.lua` - Vim options and settings (tabs=2 spaces, leader=" ")
  - `remap.lua` - Core key mappings
  - `keymap.lua` - Keymap utility functions for consistent mapping definitions
- `after/plugin/` - Plugin-specific configurations loaded after plugins

### Plugin Management Commands
```bash
# Open lazy.nvim interface
:Lazy

# Update plugins
:Lazy update

# Clean unused plugins
:Lazy clean

# Check plugin status
:Lazy check
```

## Key Bindings and Conventions

### Leader Keys
- Leader: `<space>`
- Local Leader: `\`

### Essential Mappings
- **File Navigation**:
  - `<leader>t` - Git files (Telescope)
  - `<leader>af` - All files (Telescope)
  - `<leader>b` - Buffers
- **Search**:
  - `<leader>gg` - Live grep
  - `<leader>k` - Search word under cursor
- **Harpoon** (quick file switching):
  - `<leader>h` - Add file to Harpoon
  - `<C-e>` - Toggle Harpoon menu
  - `<C-7/8/9/0>` - Navigate to Harpoon files
- **LSP**:
  - `gd` - Go to definition
  - `K` - Hover documentation
  - `<leader>vrn` - Rename symbol
  - `<leader>vca` - Code actions

### Testing (RSpec via tmux)
- `<leader>rs` - Run current spec file
- `<leader>rl` - Run nearest spec
- `<leader>rp` - Run last spec
- Commands are sent to tmux using `sp rspec {spec}` format

## Development Workflow

### LSP Configuration
The setup uses native `vim.lsp.config` (Neovim 0.11+) with automatic enabling for:
- ESLint (JavaScript/TypeScript)
- Rust Analyzer
- Lua Language Server

LSP is configured with nvim-cmp for autocompletion.

### Plugin Ecosystem
- **Navigation**: Telescope, Harpoon, NERDTree
- **Development**: LSP, TreeSitter, vim-fugitive, vim-rails
- **Testing**: vim-rspec with tmux integration
- **Editing**: vim-surround, vim-commentary, vim-easy-align
- **AI**: Copilot, Avante (using Bedrock provider)

## Important Settings
- Tabs: 2 spaces, expandtab enabled
- Clipboard: System clipboard integration enabled
- Relative line numbers with absolute current line
- No swap files, persistent undo in ~/.vim/undodir
- Color column at 120 characters
- Case-insensitive smart search

## Working with this Config

When modifying configurations:
1. Plugin additions go in `lua/noah/lazy.lua`
2. Plugin configurations go in `after/plugin/[plugin-name].lua`
3. Use the existing keymap utility functions from `lua/noah/keymap.lua`
4. Follow the 2-space indentation convention
5. Test changes with `:source %` or restart Neovim

The configuration prioritizes Ruby/Rails development with deep tmux integration for testing workflows.
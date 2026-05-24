# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration built on Kickstart.nvim with custom extensions. The structure follows a hybrid approach:

- `init.lua` - Main Kickstart configuration file (well-documented single-file base)
- `lua/kickstart/` - Optional Kickstart plugin modules 
- `lua/custom/` - Personal customizations and extensions
- `colors/tragdate.vim` - Custom colorscheme

## Key Patterns

**Plugin Management:**
- Uses `lazy.nvim` for plugin management with import system
- Custom plugins defined in `lua/custom/plugins/init.lua`
- Plugin configs organized in `lua/custom/configs/`
- LSP setup via Mason with automatic tool installation

**Configuration Structure:**
```
lua/custom/
├── options/init.lua    # Custom vim options and autocommands
├── plugins/init.lua    # Plugin definitions and lazy-loading specs
└── configs/           # Plugin-specific configuration modules
```

## Important Commands

**Setup/Maintenance:**
```bash
# Build vim-hexokinase for color preview
./fix_hexokinase.sh

# Plugin management
:Lazy update           # Update all plugins
:Mason                 # Manage LSP servers and tools
```

**Custom Workflow Commands:**
- `:CargoBuild` / `:CargoBuildRelease` - Rust compilation
- `:Gacp` - Git add, commit, push workflow  
- `<leader>lg` - LazyGit integration
- `<leader>e` - Toggle Neo-tree file explorer

## Dependencies

External tools required: `git`, `make`, `unzip`, C compiler, `ripgrep`, `fd-find`, Nerd Font

## Customization Approach

When adding features:
1. Define plugins in `lua/custom/plugins/init.lua` using lazy.nvim specs
2. Add plugin configs to `lua/custom/configs/` if substantial
3. Extend options in `lua/custom/options/init.lua`
4. Follow the import pattern: `{ import = 'custom.plugins' }`

Configuration optimized for Rust development with format-on-save, LSP integration, and Codeium AI completion.
# Neovim Configuration Setup

Your neovim configuration has been successfully migrated from bknvim to the fresh nvim installation with all your custom settings!

## Post-Installation Steps

1. **Build vim-hexokinase**:
   You need to run the following command to build the hexokinase binary:
   ```bash
   cd ~/.local/share/nvim/lazy/vim-hexokinase && make hexokinase
   ```
   Or simply run the provided script:
   ```bash
   ~/.config/nvim/fix_hexokinase.sh
   ```

2. **First Launch**:
   When you first start Neovim, it will download and install all the plugins. This might take a minute.

## Features Migrated

✅ Custom options and keymaps  
✅ Airline configuration  
✅ Custom colorscheme  
✅ Telescope keymaps  
✅ Format on save functionality  
✅ Neo-tree file explorer  
✅ Custom startup screen  
✅ Codeium AI completion  
✅ Other plugins (vim-move, lazygit, etc)  

## Customized Features

- **Nerd Font Support**: Enabled for icons and better visuals
- **Relative Line Numbers**: Enabled for easier navigation
- **Hidden Files in Neo-tree**: Configured to show hidden files
- **Telescope Keymaps**: Added your custom Telescope shortcuts
- **Format on Save**: Configured for supported filetypes

## Key Bindings

- `<leader><leader>` - Find files
- `<leader>/` - Fuzzy search in current buffer
- `<leader>gf` - Search git files
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>f` - Format current buffer
- `<leader>lg` - Open LazyGit
- `<C-g>` - Accept Codeium suggestion

Plus all your custom keymaps from your original configuration!

Enjoy your freshly updated Neovim setup!
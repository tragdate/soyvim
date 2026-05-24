-- Custom plugins installed via vim.pack.
-- This file is auto-loaded by lua/custom/plugins/init.lua.

local function gh(repo) return 'https://github.com/' .. repo end

-- Build hook MUST be registered before vim.pack.add so install/update events fire it
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'vim-hexokinase' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.system({ 'make', 'hexokinase' }, { cwd = ev.data.path }):wait()
    end
  end,
})

-- Plugins with no setup() needed
vim.pack.add {
  gh 'matze/vim-move',
  gh 'vim-airline/vim-airline',
  gh 'vim-airline/vim-airline-themes',
  gh 'sainnhe/sonokai',
  gh 'kdheepak/lazygit.nvim',
  { src = gh 'rrethy/vim-hexokinase' },
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  { src = gh 'startup-nvim/startup.nvim' },
  gh 'MunifTanjim/nui.nvim', -- neo-tree dep (plenary + web-devicons already loaded by upstream)
}

-- Apply airline tweaks (vim globals must be set before airline loads UI)
require 'custom.configs.airline-config'

-- Colorscheme: keep sonokai as default (after install)
vim.g.sonokai_style = 'default'
vim.g.sonokai_better_performance = 1
pcall(vim.cmd.colorscheme, 'sonokai')

-- Neo-tree
require('neo-tree').setup {
  window = {
    position = 'left',
    width = 30,
    statusline = false,
    mapping_options = { noremap = true, nowait = true },
  },
  filesystem = {
    filtered_items = { hide_dotfiles = false, hide_gitignored = true },
    show_hidden = true,
  },
}
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle [E]xplorer', silent = true })

-- LazyGit keymap (lazy.nvim-style 'cmd' lazy-load gone; plugin is loaded eagerly)
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })

-- Startup screen
require('startup').setup {
  header = {
    type = 'text',
    oldfiles_directory = true,
    align = 'center',
    fold_section = false,
    title = 'Header',
    margin = 0,
    content = {
      '████████╗██████╗  █████╗  ██████╗ ██████╗  █████╗ ████████╗███████╗',
      '╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝',
      '   ██║   ██████╔╝███████║██║  ███╗██║  ██║███████║   ██║   █████╗  ',
      '   ██║   ██╔══██╗██╔══██║██║   ██║██║  ██║██╔══██║   ██║   ██╔══╝  ',
      '   ██║   ██║  ██║██║  ██║╚██████╔╝██████╔╝██║  ██║   ██║   ███████╗',
      '   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝',
    },
    highlight = 'Statement',
    default_color = '',
    oldfiles_amount = 0,
  },
  body = {
    type = 'mapping',
    oldfiles_directory = false,
    align = 'center',
    fold_section = false,
    title = 'Basic Commands',
    margin = 0,
    content = {
      { ' Find File', 'Telescope find_files', '<leader>ff' },
      { ' Find Word', 'Telescope live_grep', '<leader>lg' },
      { ' Recent Files', 'Telescope oldfiles', '<leader>of' },
      { ' File Browser', 'Telescope file_browser', '<leader>fb' },
      { ' Colorschemes', 'Telescope colorscheme', '<leader>cs' },
      { ' New File', "lua require'startup'.new_file()", '<leader>nf' },
    },
    highlight = 'String',
    default_color = '',
    oldfiles_amount = 0,
  },
  footer = {
    type = 'text',
    oldfiles_directory = false,
    align = 'center',
    fold_section = false,
    title = 'Footer',
    margin = 0,
    content = { 'tragdate.ninja' },
    highlight = 'Number',
    default_color = '',
    oldfiles_amount = 0,
  },
  options = {
    mapping_keys = true,
    cursor_column = 0.5,
    empty_lines_between_mappings = true,
    disable_statuslines = true,
    paddings = { 8, 4, 2, 10 },
  },
  mappings = {
    execute_command = '<CR>',
    open_file = 'o',
    open_file_split = '<c-o>',
    open_section = '<TAB>',
    open_help = '?',
  },
  colors = {
    background = '#1f2227',
    folded_section = '#0069ff',
  },
  parts = { 'header', 'body', 'footer' },
}


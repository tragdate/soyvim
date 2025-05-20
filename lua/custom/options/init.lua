-- nvim custom options file
-- Author: TragDate

-- Set dynamic window title
vim.o.title = true
vim.o.titlestring = '%t'
vim.cmd [[
autocmd BufEnter * let &titlestring = expand("%:p")
]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Hide cmdbar if there is nothing to display
vim.opt.cmdheight = 0
-- Keep cursor in the middle of the screen
vim.o.scrolloff = 999
-- Set Font size
vim.g.font_size = 14
-- Add rust build command

vim.api.nvim_command "command! CargoBuildRelease :terminal cargo build --release; notify-send 'binary ready'"
vim.api.nvim_command "command! CargoBuild :terminal cargo build; notify-send 'build ready'"
vim.api.nvim_set_keymap('n', '|', ':lua async_cargo_build()<CR>', { noremap = true, silent = true })

function async_cargo_build()
  local handle
  local function on_exit()
    vim.loop.close(handle)
    vim.api.nvim_command 'silent !notify-send "binary ready"'
  end

  handle = vim.loop.spawn('cargo', {
    args = { 'build', '--release' },
    stdio = { nil, nil, nil },
  }, vim.schedule_wrap(on_exit))
end

function _G.format_rust_on_save_sync()
  vim.lsp.buf.format {
    async = false,
    filter = function(client)
      return client.name == 'rust_analyzer'
    end,
  }
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rs',
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    -- Write to disk first (if modified)
    if vim.bo.modified then
      vim.api.nvim_command 'write'
    end
    -- Run formatter
    vim.fn.system { 'cargo', '+nightly', 'fmt', '--', file }
    -- Reload from disk to avoid warning
    vim.api.nvim_command 'edit!'
  end,
})

function _G.format_tera_on_save()
  local view = vim.fn.winsaveview()
  vim.cmd 'normal! gg=G'
  vim.fn.winrestview(view)
end

vim.cmd [[autocmd BufWritePre *.html.tera lua format_tera_on_save()]]

function _G.md_to_pdf()
  vim.fn.system(
    'md-to-pdf ' .. vim.fn.expand '%:p' .. ' --pdf-options=\'{"format": "A4", "margin": {"top": "10mm", "right": "20mm", "bottom": "20mm", "left": "20mm"}}\''
  )
end
vim.cmd [[autocmd BufWritePost *.2pdf.md lua md_to_pdf()]]
vim.api.nvim_set_keymap('n', '<leader>c', [[:%s/\s\+\(-H\|-\{2,}\)/ \\\r\1/g<CR>]], { noremap = true, silent = true })
-- Set the font and initial size
vim.o.guifont = 'FiraCode Nerd Font Mono:h12'

-- Function to change font size
function ChangeFontSize(delta)
  local current_font = vim.o.guifont
  local name, size = string.match(current_font, '([^:]+):h(%d+)')
  size = tonumber(size) + delta
  vim.o.guifont = string.format('%s:h%d', name, size)
end

-- Keybindings to zoom in and out
vim.api.nvim_set_keymap('n', '<C-+>', ':lua ChangeFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-->', ':lua ChangeFontSize(-1)<CR>', { noremap = true, silent = true })

local function list_from_file(filepath)
  local lines = {}
  for line in io.lines(filepath) do
    table.insert(lines, line)
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'List from File',
      finder = require('telescope.finders').new_table {
        results = lines,
      },
      sorter = require('telescope.config').values.generic_sorter {},
    })
    :find()
end

_G.list_from_file = list_from_file

vim.api.nvim_set_keymap('n', '<leader>ff', [[:lua list_from_file(vim.fn.expand('%:p:h') .. '/test_list.txt')<CR>]], { noremap = true, silent = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.tera',
  command = 'set filetype=html',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'tera' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.opt.wrap = false

vim.api.nvim_create_user_command('Gacp', function()
  local message = vim.fn.input 'Commit message: '
  vim.fn.system('git add . && git commit -am "' .. message .. '" && git push')
end, {})

vim.diagnostic.config {
  virtual_text = true,
}
vim.api.nvim_set_keymap('n', '<leader><Del>', [[:%s,//.*,,g<CR>]], { noremap = true, silent = true })

_G.StripRustComments = function()
  local files = vim.fn.systemlist "find ./src -name '*.rs'"

  for _, file in ipairs(files) do
    vim.cmd('edit ' .. file)
    pcall(vim.cmd, [[%s,//.*,,g]])
    vim.cmd 'write'
  end
end

vim.api.nvim_set_keymap('n', '<leader><S-Del>', [[:lua StripRustComments()<CR>]], { noremap = true, silent = true })

-- Set Nerd Font to true to enable icons
vim.g.have_nerd_font = true

-- Turn on relative line numbers
vim.opt.number = true
vim.opt.relativenumber = false


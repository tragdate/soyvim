-- nvim custom options file
-- Author: TragDate

-- Hide cmdbar if there is nothing to display
vim.opt.cmdheight = 0
-- Keep cursor in the middle of the screen
vim.o.scrolloff = 999
-- Set Font size
vim.g.font_size = 14
-- Add hotkeys for neovide since it does not support zooming
vim.api.nvim_set_keymap('n', '<C-=>', ':lua vim.g.font_size = vim.g.font_size + 1; vim.cmd("set guifont=JetBrainsMono\\\\ Nerd\\\\ Font:h" .. vim.g.font_size .. "")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-->', ':lua vim.g.font_size = vim.g.font_size - 1; vim.cmd("set guifont=JetBrainsMono\\\\ Nerd\\\\ Font:h" .. vim.g.font_size .. "")<CR>', {noremap = true, silent = true})

-- Add rust build command 
vim.api.nvim_command("command! CargoBuildRelease :terminal cargo build --release")

-- Add rust formating on save
function _G.format_rust_on_save()
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    options = {
      tabSize = 4,
      insertSpaces = true
    }
  }
  vim.lsp.buf_request(0, "textDocument/formatting", params, nil)
end
vim.cmd([[autocmd BufWritePre *.rs lua format_rust_on_save()]])


function _G.md_to_pdf()
  vim.fn.system("md-to-pdf " .. vim.fn.expand("%:p") .. " --pdf-options='{\"format\": \"A4\", \"margin\": {\"top\": \"10mm\", \"right\": \"20mm\", \"bottom\": \"20mm\", \"left\": \"20mm\"}}'")
end
vim.cmd([[autocmd BufWritePost *.2pdf.md lua md_to_pdf()]])

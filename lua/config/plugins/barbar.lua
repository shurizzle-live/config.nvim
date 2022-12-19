require('bufferline').setup {
  auto_hide = true,
}

vim.keymap.set('n', '<C-n>', '<cmd>BufferNext<cr>')
vim.keymap.set('n', '<C-p>', '<cmd>BufferPrevious<cr>')
vim.keymap.set('n', 'ZZ', '<cmd>BufferClose<cr>')

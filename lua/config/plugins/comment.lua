require('Comment').setup {
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
}

vim.keymap.set('n', '<leader>c/', '<Plug>(comment_toggle_linewise_current)', { noremap = true, silent = true, expr = false, desc = 'Toggle comments' })

vim.keymap.set('x', '<leader>c/', '<Plug>(comment_toggle_linewise_visual)', { noremap = true, silent = true, expr = false, desc = 'Toggle comments' })

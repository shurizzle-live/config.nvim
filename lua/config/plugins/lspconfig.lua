local lsp = require 'lspconfig'
local lsputil = require 'lspconfig.util'

local function on_attach(client, bufnr)
  vim.api.nvim_create_autocmd({ 'BufWritepre' }, {
    pattern = { '*' },
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
  })

  vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    pattern = { '*' },
    callback = function()
      vim.diagnostic.open_float()
    end,
  })

  local options = { silent = true, buffer = true }

  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
  end, vim.tbl_deep_extend('force', options, { desc = 'show help under cursor' }))

  vim.keymap.set('n', '<leader>ce', function()
    vim.diagnostic.open_float()
  end, vim.tbl_deep_extend('force', options, { desc = 'open diagnostic float' }))

  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, vim.tbl_deep_extend('force', options, { desc = 'LSP code action' }))

  vim.keymap.set('n', '<leader>cr', function()
    vim.lsp.buf.rename()
  end, vim.tbl_deep_extend('force', options, { desc = 'Rename under cursor' }))

  vim.keymap.set('n', '<leader>cD', function()
    vim.lsp.buf.declaration()
  end, vim.tbl_deep_extend('force', options, { desc = 'Show under-cursor declaration' }))

  vim.keymap.set('n', '<leader>cD', function()
    vim.lsp.buf.definition()
  end, vim.tbl_deep_extend('force', options, { desc = 'Show under-cursor definition' }))

  vim.keymap.set('n', '<leader>ci', function()
    vim.lsp.buf.implementation()
  end, vim.tbl_deep_extend('force', options, { desc = 'Show under-cursor implementation' }))

  vim.keymap.set('n', '<leader>ct', function()
    vim.lsp.buf.type_definition()
  end, vim.tbl_deep_extend('force', options, { desc = 'Show under-cursor type definition' }))

  vim.keymap.set('n', '<leader>cR', function()
    vim.lsp.buf.references {}
  end, vim.tbl_deep_extend('force', options, { desc = 'Show under-cursor references' }))

  require('lsp_signature').on_attach({
    floating_window_above_cur_line = true,
    floating_window = true,
    transparency = 10,
  }, bufnr)
end

lsputil.on_setup = lsputil.add_hook_before(lsputil.on_setup, function(cfg)
  cfg.cababilities = vim.tbl_deep_extend('force', require('cmp_nvim_lsp').default_capabilities(), cfg.capabilities or {})
  cfg.on_attach = lsputil.add_hook_before(cfg.on_attach, on_attach)
end)

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local diag_config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(diag_config)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

lsp.pyright.setup {}

lsp.sumneko_lua.setup {}

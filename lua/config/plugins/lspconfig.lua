local lsp = require 'lspconfig'
local lsputil = require 'lspconfig.util'

lsputil.on_setup = lsputil.add_hook_before(lsputil.on_setup, function(cfg)
  cfg.cababilities = vim.tbl_deep_extend('force', require('cmp_nvim_lsp').default_capabilities(), cfg.capabilities or {})
end)

local function on_attach()
  vim.api.nvim_create_autocmd({ 'BufWritepre' }, {
    pattern = { '*' },
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
  })
end

require('lspconfig').pyright.setup {
  on_attach = on_attach,
}
require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
}

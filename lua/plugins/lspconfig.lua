local M = {
  'neovim/nvim-lspconfig', 
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', 
  }
}

M.config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.enable('clangd')

  vim.lsp.config('clangd', {
    cmd = { "clangd", "--background-index" },
    capabilities = capabilities,

    on_attach = function(client, bufnr)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    end,
  })

  vim.lsp.enable('qmlls')

  vim.lsp.config('qmlls', {
    cmd = { "qmlls6", "-I", "/usr/lib/qt6/qml/", "-E" },
    capabilities = capabilities,

    on_attach = function(client, bufnr)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    end,
  })

  vim.lsp.enable('gopls')

  vim.lsp.config('gopls', {
   cmd = { "gopls" },
    capabilities = capabilities,

    on_attach = function(client, bufnr)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    end,
  })

end

return M

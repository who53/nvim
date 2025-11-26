local M = {
  'neovim/nvim-lspconfig', 
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', 
  }
}

M.config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('clangd', {
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    capabilities = capabilities,

    on_attach = function(client, bufnr)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    end,
  })

  vim.lsp.enable('clangd')
end

return M

local M = {
  'hrsh7th/nvim-cmp', 
  dependencies = {
    'hrsh7th/cmp-buffer',    
    'hrsh7th/cmp-path',      
    'hrsh7th/cmp-nvim-lsp',  
    'L3MON4D3/LuaSnip',      
    'saadparwaiz1/cmp_luasnip', 
    'onsails/lspkind-nvim',  
    'nvim-tree/nvim-web-devicons', 
  }
}

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  
  lspkind.init()

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then return false end
    local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    return not line_text:sub(col, col):match("%s")
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() 
        end
      end, { "i", "s" }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback() 
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' }, 
      { name = 'buffer' },   
      { name = 'path' },     
      { name = 'luasnip' },  
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol', 
        maxwidth = 50,   
        ellipsis_char = '...', 
        show_labelDetails = true, 

        before = function(entry, vim_item)
          
          vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind 
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })[entry.source.name] or ''
          return vim_item
        end,
      }),
    },
  })
end

return M

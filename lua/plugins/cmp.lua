local M = {
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  dependencies = {
    'hrsh7th/cmp-buffer',    -- Buffer completions
    'hrsh7th/cmp-path',      -- Path completions
    'hrsh7th/cmp-nvim-lsp',  -- LSP completions
    'L3MON4D3/LuaSnip',      -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- LuaSnip completions
    'onsails/lspkind-nvim',  -- Icons for completion
    'nvim-tree/nvim-web-devicons', -- Icons for file types
  }
}

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  -- Initialize lspkind
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
          fallback() -- Fall back to default Tab behavior
        end
      end, { "i", "s" }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback() -- Fall back to default Shift-Tab behavior
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' }, -- LSP completion
      { name = 'buffer' },   -- Buffer completion
      { name = 'path' },     -- Path completion
      { name = 'luasnip' },  -- Snippet completion
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol', -- Show only symbol annotations
        maxwidth = 50,   -- Prevent popup from exceeding this width
        ellipsis_char = '...', -- Truncated part shows this if exceeded
        show_labelDetails = true, -- Show label details in menu

        -- Function for additional customization
        before = function(entry, vim_item)
          -- Customize here (you can modify vim_item as needed)
          vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind -- Add icon
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

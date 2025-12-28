require("config.lazy")
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.undolevels = 300
vim.opt.termguicolors = true
vim.opt.syntax = "on"

vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":%normal = GG<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>]", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>[", ":bprevious<CR>", { noremap = true, silent = true })

local term_buf = nil
local term_win = nil

vim.keymap.set("n", "<leader>i", function()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
  end
  term_win = vim.api.nvim_open_win(term_buf, true, opts)
  if vim.bo[term_buf].buftype ~= "terminal" then
    vim.fn.termopen("fish")
  end
  vim.cmd("startinsert")
end, { noremap = true, silent = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<leader>' .. key .. '', function()
    vim.cmd('wincmd ' .. key)
    vim.cmd('stopinsert')
  end, { noremap = true })
end

vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", function() vim.lsp.buf.code_action() end, { noremap = true, silent = true })

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

local function skip_term(direction)
  local cur = vim.api.nvim_get_current_buf()
  repeat
    vim.cmd(direction)
  until vim.bo.buftype ~= "terminal" or vim.api.nvim_get_current_buf() == cur
end

vim.keymap.set("n", "<leader>]", function() skip_term("bnext") end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>[", function() skip_term("bprevious") end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
})

vim.keymap.set("n", "<leader>t", function()
    vim.cmd.vnew()
    vim.cmd.term("fish")
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 7)
    vim.cmd("stopinsert")
end, { noremap = true, silent = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<leader>' .. key .. '', function()
    vim.cmd('wincmd ' .. key)
    vim.cmd('stopinsert')
  end, { noremap = true })
end

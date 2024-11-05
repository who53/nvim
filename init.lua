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

vim.api.nvim_create_augroup("AutoGG", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = "AutoGG",
    pattern = { "*.c", "*.h" },
    callback = function()
        vim.cmd("normal! GG")
    end
})

vim.api.nvim_set_keymap("n", "<leader>f", ":normal! GG<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>[", ":bnext<CR>", { noremap = true, silent = true })  
vim.api.nvim_set_keymap("n", "<leader>]", ":bprevious<CR>", { noremap = true, silent = true })  

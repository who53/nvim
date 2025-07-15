local M = {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
}

M.config = function()
    vim.cmd([[colorscheme nightfly]])
end

return M

local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
}

M.config = function()
    require("nvim-treesitter.configs").setup{
        ensure_installed = "",
        auto_install = true,
        highlight = {
            enable = true,  
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    }
end

return M

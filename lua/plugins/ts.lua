local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
}

M.config = function()
    require("nvim-treesitter.configs").setup{
        ensure_installed = "",

        auto_install = true,

        highlight = {
            enable = true,  -- Enable syntax highlighting
            additional_vim_regex_highlighting = false,
        },

        -- Indentation based on treesitter
        indent = {
            enable = true,
        },
    }
end

return M

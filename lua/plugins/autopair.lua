local M = {
    "windwp/nvim-autopairs",
}

M.config = function()
    require("nvim-autopairs").setup()
    event = "InsertEnter"
end

return M

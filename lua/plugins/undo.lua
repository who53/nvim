local M = {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim"
}

M.config = function()
    
    require("undotree").setup()
    
    local mappings = {
        { 'n', '<leader>u', function() require('undotree').toggle() end }
    }
    
    local opts = { noremap = true, silent = true }
    
    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end
return M

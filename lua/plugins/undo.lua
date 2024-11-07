local M = {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim"
}

M.config = function()
    
    local undotree = require("undotree")

    undotree.setup({
        float_diff = true,
        layout = "left_bottom",
        position = "left",
        ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
        window = {
            winblend = 30,
        },
        keymaps = {
            ['j'] = "move_next",
            ['k'] = "move_prev",
            ['gj'] = "move2parent",
            ['J'] = "move_change_next",
            ['K'] = "move_change_prev",
            ['<cr>'] = "action_enter",  
            ['p'] = "enter_diffbuf",
            ['q'] = "quit",
        },
    })

    local is_moving = false

    vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",  
        callback = function()
            
            local ft = vim.bo.filetype
            if ft == "undotree" or ft == "undotreeDiff" then
                
                if is_moving then
                    
                    is_moving = false

                    
                    vim.api.nvim_win_call(0, function()
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), 'n', true)
                    end)
                end
            end
        end,
    })
    
    local mappings = {
        { 'n', '<leader>u', function() undotree.toggle() end },
        { 'n', 'j', function() is_moving = true; vim.cmd('normal! j') end },  
        { 'n', 'k', function() is_moving = true; vim.cmd('normal! k') end },  
    }

    local opts = { noremap = true, silent = true }

    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end

return M

local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
}

M.config = function()
    require("telescope").setup{
        defaults = {
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                },
                width = 0.87,
                height = 0.80,
            },
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
                n = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["q"] = require('telescope.actions').close, 
                },
            },
        }
    }

    local toggle_modes = { 'n' }

    local mappings = {
        { toggle_modes, '<leader>ff', function() require('telescope.builtin').find_files() end },
        { toggle_modes, '<leader>fw', function() require('telescope.builtin').live_grep() end },
    }

    local opts = { noremap = true, silent = true }

    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end

return M

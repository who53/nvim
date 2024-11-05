local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
}

M.config = function()
    require("telescope").setup{
        defaults = {
            -- Default configuration for telescope
            mappings = {
                i = {
                    -- Key mappings in insert mode
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
                n = {
                    -- Key mappings in normal mode
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["q"] = require('telescope.actions').close, -- Make 'q' quit Telescope
                },
            },
        }
    }

    -- Leader key mappings
    local toggle_modes = { 'n' }

    local mappings = {
        { toggle_modes, '<leader>ff', function() require('telescope.builtin').find_files() end },
        { toggle_modes, '<leader>fg', function() require('telescope.builtin').live_grep() end },
        { toggle_modes, '<leader>fw', function() require('telescope.builtin').grep_string() end }, -- Grep current word
    }

    local opts = { noremap = true, silent = true }

    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end

return M

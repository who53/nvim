-- Load the telescope plugin
local M = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
}

M.config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    -- Setup telescope with defaults
    telescope.setup {
        defaults = {
            prompt_prefix = "> ",
            selection_caret = "> ",
            path_display = { "truncate" },
            mappings = {
                i = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-c>"] = actions.close,
                },
                n = {
                    ["<C-c>"] = actions.close,
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                previewer = false,
            },
            live_grep = {
                theme = "dropdown",
            },
            git_files = {
                theme = "dropdown",
                previewer = false,
            },
        },
    }

    -- Load telescope extensions if needed
    -- telescope.load_extension('fzy_native')  -- Example of loading an extension

    -- Key mappings for telescope commands
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts) -- Find files
    map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts) -- Live grep
    map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts) -- List buffers
    map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts) -- Help tags
    map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', opts) -- Git commits
    map('n', '<leader>gs', '<cmd>Telescope git_status<CR>', opts) -- Git status
    map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', opts) -- Git branches
end

return M

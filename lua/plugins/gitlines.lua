local M = {
    "lewis6991/gitsigns.nvim"
}

M.config = function()
    require("gitsigns").setup()

    local gitsigns = require("gitsigns")

    local toggle_modes = {'n'}

    local mappings = {
        { toggle_modes, "<leader>gj", gitsigns.next_hunk },
        { toggle_modes, "<leader>gk", gitsigns.prev_hunk },
        { toggle_modes, "<leader>gp", gitsigns.preview_hunk },
        { toggle_modes, "<leader>gb", gitsigns.blame_line },
        { toggle_modes, "<leader>gr", gitsigns.reset_hunk },
        { toggle_modes, "<leader>gR", gitsigns.reset_buffer },
        { toggle_modes, "<leader>gs", gitsigns.stage_hunk },
        { toggle_modes, "<leader>gu", gitsigns.undo_stage_hunk }
    }

    local opts = { noremap = true, silent = true }

    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end

return M

local M = {
    "NvChad/nvterm"
}

M.config = function()
    require("nvterm").setup({
        terminals = {
            shell = "fish",  -- use fish shell only in nvterm
        },
    })

    local terminal = require("nvterm.terminal")

    local toggle_modes = {'n', 't'}

    local mappings = {
        { toggle_modes, "<leader>i", function() terminal.toggle('float') end },
    }

    local opts = { noremap = true, silent = true }

    for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
end

return M

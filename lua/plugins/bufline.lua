return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup {
      options = {
        custom_filter = function(bufnr)
          return vim.bo[bufnr].buftype ~= "terminal"
        end,
      },
    }
  end,
}

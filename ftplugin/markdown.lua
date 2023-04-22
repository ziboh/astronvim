---@diagnostic disable-next-line: undefined-field
local current_buf = vim.api.nvim_get_current_buf()
---@diagnostic disable-next-line: undefined-field
local bufnr = vim.api.nvim_buf_get_number(current_buf)

local opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

require("which-key").register(
  {
    m = {
      name = "Markdown",
      r = { "<cmd>MarkdownPreview<cr>", "Preview" },
      s = { "<cmd>MarkdownPreviewStop<cr>", "Stop" },
      t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle" },
      g = { "<cmd>Glow<cr>", "Glow" },
    }
  },
  opts
)

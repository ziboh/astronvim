return {
  'ghillb/cybu.nvim',
  branch = "main",                                                           -- timely updates
  -- branch = "v1.x", -- won't receive breaking changes
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
  opts = {},
  keys = {
    { "K",         "<Plug>(CybuPrev)" },
    { "J",         "<Plug>(CybuNext)" },
    { "<C-s-\\>", "<plug>(CybuLastusedPrev)" },
    { "<C-\\>",   "<plug>(CybuLastusedNext)" }
  }
}

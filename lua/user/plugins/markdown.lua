return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = 'markdown',
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  { "ellisonleao/glow.nvim", opts = {border = 'single'}, cmd = "Glow" },

}

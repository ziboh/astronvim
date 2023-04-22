return {
  {
    "s1n7ax/nvim-window-picker",
    opts = function(_, opts)
      opts.filter_rules = {
        bo = {
          buftype = {},
        },
      }
      opts.show_prompt = false
      return opts
    end,
    keys = {
      { "<leader>wp", '<cmd>lua require"user.utils".pick_windows()<cr>', desc = "pick window" },
      { "<leader>ws", '<cmd>lua require"user.utils".swap_windows()<cr>', desc = "swap windows" },
    },
  },
}

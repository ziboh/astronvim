return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window.mappings.i = "open"
    opts.window.mappings["<S-tab>"] = "prev_source"
    opts.window.mappings["<tab>"] = "next_source"
    opts.event_handlers = {
      {
        event = "neo_tree_window_before_open",
        handler = function(_)
          require("overseer").close()
          require("dapui").close()
          vim.cmd.UndotreeHide()
        end,
      },
    }
    return opts
  end,
}

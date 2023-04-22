return {
  "windwp/nvim-spectre",
  event = "BufRead",
  opts = {
    mapping = {
      ['send_to_qf'] = {
        map = "<leader>w",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"

      }
    }

  },
  keys = {
    { "<leader>so", '<cmd>lua require("spectre").open()<CR>', desc = "Open Spectre" },
    {
      "<leader>sw",
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      desc = "Search current word",
    },
    {
      "<leader>sw",
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      desc = "Search current word",
      mode = "v",
    },
    {
      "<leader>sp",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      desc = "Search on current file",
    },
  },
}

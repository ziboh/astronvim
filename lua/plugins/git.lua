-- if true then return {} end

return {
  {
    "wintermute-cell/gitignore.nvim",
    config = function() require "gitignore" end,
    keys = { { "<leader>gi", "<cmd>Gitignore<cr>", desc = "generate gitignore file" } },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local is_ok, gitsigns = pcall(require, "gitsigns")
      if not is_ok then return end

      gitsigns.setup {
        yadm = {
          enable = true,
        },
      }
    end,
    event = "VeryLazy",
    keys = {
      {
        "<leader>g",
        desc = "Git",
      },
      {
        "]g",
        function() require("gitsigns").next_hunk() end,
        desc = "Next Git hunk",
      },
      {
        "[g",
        function() require("gitsigns").prev_hunk() end,
        desc = "Previous Git hunk",
      },
      {
        "<Leader>gl",
        function() require("gitsigns").blame_line() end,
        desc = "View Git blame",
      },
      {
        "<Leader>gL",
        function() require("gitsigns").blame_line { full = true } end,
        desc = "View full Git blame",
      },
      {
        "<Leader>gp",
        function() require("gitsigns").preview_hunk_inline() end,
        desc = "Preview Git hunk",
      },
      {
        "<leader>gh",
        function() require("gitsigns").reset_hunk() end,
        desc = "Reset Git hunk",
      },
      {
        "<leader>gr",
        function() require("gitsigns").reset_buffer() end,
        desc = "Reset Git buffer",
      },
      {
        "<leader>gs",
        function() require("gitsigns").stage_hunk() end,
        desc = "Stage Git hunk",
      },
      {
        "<leader>gS",
        function() require("gitsigns").stage_buffer() end,
        desc = "Stage Git buffer",
      },
      {
        "<leader>gu",
        function() require("gitsigns").undo_stage_hunk() end,
        desc = "Unstage Git hunk",
      },
    },
  },
}

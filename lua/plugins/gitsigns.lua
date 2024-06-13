return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local is_ok, gitsigns = pcall(require, "gitsigns")
      if not is_ok then return end

      gitsigns.setup {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
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

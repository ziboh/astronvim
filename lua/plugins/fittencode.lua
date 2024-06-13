return {
  {
    "luozhiya/fittencode.nvim",
    event = "User AstroFile",
    cmd = "Fitten",
    opts = {
      action = {
        document_code = {
          -- Show "Fitten Code - Document Code" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
        edit_code = {
          -- Show "Fitten Code - Edit Code" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
        explain_code = {
          -- Show "Fitten Code - Explain Code" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
        find_bugs = {
          -- Show "Fitten Code - Find Bugs" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
        generate_unit_test = {
          -- Show "Fitten Code - Generate UnitTest" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
        start_chat = {
          -- Show "Fitten Code - Start Chat" in the editor context menu, when you right-click on the code.
          show_in_editor_context_menu = true,
        },
      },
      disable_specific_inline_completion = {
        -- Disable auto-completion for some specific file suffixes by entering them below
        -- For example, `suffixes = {'lua', 'cpp'}`
        suffixes = {},
      },
      inline_completion = {
        -- Enable inline code completion.
        ---@type boolean
        enable = true,
        -- Disable auto completion when the cursor is within the line.
        ---@type boolean
        disable_completion_within_the_line = false,
        -- Disable auto completion when pressing Backspace or Delete.
        ---@type boolean
        disable_completion_when_delete = false,
        -- Auto triggering completion
        ---@type boolean
        auto_triggering_completion = true,
      },
      delay_completion = {
        -- Delay time for inline completion (in milliseconds).
        ---@type integer
        delaytime = 0,
      },
      -- Enable/Disable the default keymaps in inline completion.
      use_default_keymaps = true,
      -- Setting for source completion.
      source_completion = {
        -- Enable source completion.
        enable = true,
      },
      -- Set the mode of the completion.
      -- Available options:
      -- - 'inline' (VSCode style inline completion)
      -- - 'source' (integrates into other completion plugins)
      completion_mode = "source",
      ---@class LogOptions
      log = {
        -- Log level.
        level = vim.log.levels.WARN,
        -- Max log file size in MB, default is 10MB
        max_size = 10,
      },
    },
  },
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.mapping = {
        ["<cr>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false },
      }
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        {
          name = "fittencode",
          group_index = 1,
          priority = 10000,
        },
      }
    end,
  },
}

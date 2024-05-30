return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>s"] = { name = "󱂬 Session" },
          ["<Leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" },
          ["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" },
          ["<Leader>sD"] = {
            function() require("resession").delete(nil, { dir = "dirsession" }) end,
            desc = "Delete a dirsession",
          },
          ["<Leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" },
          ["<Leader>sS"] = { function() require("resession").save() end, desc = "Save this session" },
          ["<Leader>sF"] = { function() require("resession").load() end, desc = "Load a session" },
          ["<Leader>sf"] = {
            function() require("resession").load(nil, { dir = "dirsession" }) end,
            desc = "Load a dirsession",
          },
          ["<Leader>ss"] = {
            function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
            desc = "Save this dirsession",
          },
          -- update load dirsession mapping to get the correct session name
          ["<Leader>s."] = {
            function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
            desc = "Load current dirsession",
          },

          ["L"] = { "$", desc = "Move to end of line" },
          ["H"] = { "^", desc = "Move to first non-blank character" },
          ["<A-k>"] = { ":m .-2<CR>==", desc = "Increase window height" },
          ["<A-j>"] = { ":m .+1<CR>==", desc = "Decrease window height" },
          ["M"] = { "J", desc = "Join the current line with the next line" },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader><space>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          ["<C-K>"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["<C-J>"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["<leader>Ss"] = false,
          ["<leader>SS"] = false,

          ["<C-_>"] = {
            function()
              return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
              )()
            end,
            expr = true,
            silent = true,
            desc = "Toggle comment line",
          },
          ["<leader>w"] = { name = "window" },
          ["<leader>ww"] = { "<c-w>w", desc = "other window" },
          ["<leader>wd"] = { "<c-w>c", desc = "delete window" },
          ["<leader>wl"] = { "<c-w>v", desc = "spite window right" },
          ["<leader>wj"] = { "<c-w>s", desc = "splite window below" },
          ["<leader>wo"] = { "<c-w>o", desc = "only window" },
          ["<leader>wf"] = { "<c-w>pa", desc = "switch window" },
        },
        v = {
          ["L"] = { "$h", desc = "Move to end of line" },
          ["H"] = { "^", desc = "Move to first non-blank character" },
          ["<A-j>"] = { ":m '>+1<CR>gv-gv", desc = "Move line down" },
          ["<A-k>"] = { ":m '<-2<CR>gv-gv", desc = "Move line up" },
        },
        i = {
          ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" },
          ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        x = {
          ["<C-_>"] = {
            "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
            desc = "Toggle comment for selection",
          },
        },
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}

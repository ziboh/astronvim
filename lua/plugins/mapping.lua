return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local maps = opts.mappings
    maps.n["<Leader>S"] = false
    maps.n["<Leader>Sl"] = false
    maps.n["<Leader>Ss"] = false
    maps.n["<Leader>SS"] = false
    maps.n["<Leader>St"] = false
    maps.n["<Leader>Sd"] = false
    maps.n["<Leader>SD"] = false
    maps.n["<Leader>Sf"] = false
    maps.n["<Leader>SF"] = false
    maps.n["<Leader>S."] = false
    maps.n["<Leader>h"] = false
    maps.n["<Leader>o"] = false

    maps.n["<Leader>s"] = { name = "󱂬 Session" }
    maps.n["<Leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
    maps.n["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
    maps.n["<Leader>sD"] = {
      function() require("resession").delete(nil, { dir = "dirsession" }) end,
      desc = "Delete a dirsession",
    }
    maps.n["<Leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
    maps.n["<Leader>sS"] = { function() require("resession").save() end, desc = "Save this session" }
    maps.n["<Leader>sF"] = { function() require("resession").load() end, desc = "Load a session" }
    maps.n["<Leader>sf"] = {
      function() require("resession").load(nil, { dir = "dirsession" }) end,
      desc = "Load a dirsession",
    }
    maps.n["<Leader>ss"] = {

      function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
      desc = "Save this dirsession",
    }
    -- update load dirsession mapping to get the correct session name

    maps.n["<Leader>s."] = {
      function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
      desc = "Load current dirsession",
    }
    maps.n["L"] = { "$", desc = "Move to end of line" }
    maps.n["H"] = { "^", desc = "Move to first non-blank character" }
    maps.n["<A-k>"] = { ":m .-2<CR>==", desc = "Increase window height" }
    maps.n["<A-j>"] = { ":m .+1<CR>==", desc = "Decrease window height" }
    maps.n["M"] = { "J", desc = "Join the current line with the next line" }
    maps.n["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
    maps.n["<Leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    }
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    maps.n["<Leader>b"] = { name = "Buffers" }
    maps.n["<Leader><space>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
    -- quick save
    -- maps.n["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    maps.n["<C-K>"] = {
      function() require("astrocore.buffer").nav(vim.v.count1) end,
      desc = "Next buffer",
    }
    maps.n["<C-J>"] = {
      function() require("astrocore.buffer").nav(-vim.v.count1) end,
      desc = "Previous buffer",
    }

    maps.n["<C-_>"] = {
      function()
        return require("Comment.api").call(
          "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
          "g@$"
        )()
      end,
      expr = true,
      silent = true,
      desc = "Toggle comment line",
    }
    maps.n["<leader>w"] = { name = "window" }
    maps.n["<leader>ww"] = { "<c-w>w", desc = "other window" }
    maps.n["<leader>wd"] = { "<c-w>c", desc = "delete window" }
    maps.n["<leader>wl"] = { "<c-w>v", desc = "spite window right" }
    maps.n["<leader>wj"] = { "<c-w>s", desc = "splite window below" }
    maps.n["<leader>wo"] = { "<c-w>o", desc = "only window" }
    maps.n["<leader>wf"] = { "<c-w>pa", desc = "switch window" }

    maps.v["L"] = { "$h", desc = "Move to end of line" }
    maps.o["L"] = { "$", desc = "Move to end of line" }
    maps.v["H"] = { "^", desc = "Move to first non-blank character" }
    maps.o["H"] = { "^", desc = "Move to first non-blank character" }
    maps.v["<A-j>"] = { ":m '>+1<CR>gv-gv", desc = "Move line down" }
    maps.v["<A-k>"] = { ":m '<-2<CR>gv-gv", desc = "Move line up" }

    maps.i["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" }
    maps.i["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" }

    maps.t["<C-_>"] = {
      "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
      desc = "Toggle comment for selection",
    }
  end,
}

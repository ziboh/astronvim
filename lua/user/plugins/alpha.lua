return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    opts.section.header.val = {
      "███████╗██╗██████╗░░█████╗░",
      "╚════██║██║██╔══██╗██╔══██╗",
      "░░███╔═╝██║██████╦╝██║░░██║",
      "██╔══╝░░██║██╔══██╗██║░░██║",
      "███████╗██║██████╦╝╚█████╔╝",
      "╚══════╝╚═╝╚═════╝░░╚════╝░",
    }
    -- opts.section.header.opts.hl = "DashboardHeader"

    local button = require("astronvim.utils").alpha_button
    opts.section.buttons.val = {
      button("LDR n", "  New File  "),
      button("LDR SPC", "  Find File  "),
      button("LDR f o", "  Recents  "),
      button("LDR f w", "  Find Word  "),
      button("LDR f '", "  Bookmarks  "),
      button("LDR s l", "  Last Session  "),
    }

    -- opts.config.layout[1].val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }
    -- opts.config.layout[3].val = 5
    -- opts.config.opts.noautocmd = true
    return opts
  end,
}

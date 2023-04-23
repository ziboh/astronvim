return {
  g = {
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    winblend = 0,             -- transparency of the popup window
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
    python3_host_prog = vim.fn.expand("~") .. "/.pyenv/versions/pynvim/bin/python",
  },
  opt = {
    wrap = true,
  },
}

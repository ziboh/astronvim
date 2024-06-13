-- if true then return {} end
return {
  "ojroques/nvim-osc52",
  enabled = vim.loop.os_uname().sysname == "Linux"
}

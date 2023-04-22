return {
  -- better quick fix
  "kevinhwang91/nvim-bqf",
  event = "User AstroGitFile",
  config = function()
    require('bqf').setup(
      {
        func_map = {
          pscrollup = "<C-u>",
          pscrolldown = "<C-d>"
        },
      }
    )
  end
}

return {
  settings = {
    pylsp = {
      plugins = {
        ruff = { enabled = true, ignore = { "E501" } },
        autopep8 = { enabled = false },
        yapf = { enabled = true, based_on_style = "google", indent_width = 2 },
        black = { enabed = false },
        pycodestyle = { enabled = false, indentSize = 2, maxLineLength = 80 },
        isort = { enabled = true },
        rope_autoimport = { enabled = true },
      },
    },
  },
}

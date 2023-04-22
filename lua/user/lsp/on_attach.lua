return function(client, bufnr)
  local utils = require "astronvim.utils"
  local capabilities = client.server_capabilities
  local lsp_mappings = {}
  if capabilities.codeLensProvider then
    vim.lsp.codelens.refresh()
    lsp_mappings.n["<leader>lp"] = {
      function() vim.lsp.codelens.refresh() end,
      desc = "LSP CodeLens refresh",
    }
  end
  utils.set_mappings(lsp_mappings, { buffer = bufnr })
end

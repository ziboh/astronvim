local is_available = require("astronvim.utils").is_available
return function(lsp_mappings)
	lsp_mappings.n["<leader>lh"] = {
		function()
			vim.lsp.buf.hover()
		end,
		desc = "Hover symbol details",
	}

	lsp_mappings.n["<leader>lH"] = {
		function()
			vim.lsp.buf.signature_help()
		end,
		desc = "Signature help",
	}
	lsp_mappings.n["<leader>h"] = {
		function()
			vim.lsp.buf.hover()
		end,
		desc = "Hover symbol details",
	}
	lsp_mappings.n["K"] = {
		function()
			vim.cmd("Lazy load cybu.nvim")
			vim.cmd("CybuPrev")
		end,
		desc = "CybuPrev",
	}

	if is_available("lsp_lines.nvim") then
		lsp_mappings.n["<leader>ll"] = {
			require("lsp_lines").toggle,
			desc = "Toggle LSP lines",
		}
	end
	return lsp_mappings
end

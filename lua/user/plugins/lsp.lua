return {
	"p00f/clangd_extensions.nvim", -- install lsp plugin
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_,opts)
			opts.ensure_installed = { "clangd" }
		end,
	},
	{
		"onsails/lspkind.nvim",
		opts = {
			mode = "symbol",
			symbol_map = {
				Copilot = "",
			},
		},
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		enabled = true,
		opts = {
			virtual_lines = { only_current_line = true },
		},
		config = function()
			require("lsp_lines").setup()
			require("lsp_lines").toggle()
		end,
	},
}

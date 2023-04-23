return {
	"p00f/clangd_extensions.nvim", -- install lsp plugin
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "clangd" }, -- automatically install lsp
		},
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
		opts = {
			virtual_lines = { only_current_line = true },
		},
		config = function()
			require("lsp_lines").setup()
			require("lsp_lines").toggle()
		end,
	},
}

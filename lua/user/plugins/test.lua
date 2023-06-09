return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
		"rouge8/neotest-rust",
		{
			"folke/neodev.nvim",
			opts = function(_, opts)
				opts.library = { plugins = { "neotest" }, types = true }
			end,
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuration
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					-- args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "unittest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					python = require("user.utils").get_workpath_python_resolve(),
					-- Returns if a given file path is a test file.
					-- NB: This function is called a lot so don't perform any heavy tasks within it.
				}),
				require("neotest-plenary"),
				require("neotest-rust"),
			},
		})
	end,
	keys = {
		{
			"<leader>tc",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run the current file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug the nearest test",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run the nearest test",
		},
	},
}

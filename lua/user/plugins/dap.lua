return {
	"mfussenegger/nvim-dap-python",
	{
		"rcarriga/nvim-dap-ui",
		enabled = vim.fn.has("win32") == 0,
		config = function(plugin, opts)
			-- run default AstroNvim nvim-dap-ui configuration function
			require("plugins.configs.nvim-dap-ui")(plugin, opts)

			-- disable dap events that are created
			local dap = require("dap")
			-- dap.listeners.after.event_initialized["dapui_config"] = nil
			dap.listeners.before.event_terminated["dapui_config"] = nil
			dap.listeners.before.event_exited["dapui_config"] = nil
		end,
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		enabled = vim.fn.has("win32") == 0,
		event = "User AstroFile",
		opts = {
			save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
			-- when to load the breakpoints? "BufReadPost" is recommanded.
			load_breakpoints_event = { "BufReadPost", "User SessionLoadPost" },
			-- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
			perf_record = false,
		},
	},
}

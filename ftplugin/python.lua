if vim.fn.has("win32") == 0 then
	-- 设置键映射
	vim.defer_fn(function()
		local api = vim.api
		api.nvim_buf_set_keymap(
			0,
			"n",
			"<leader>dr",
			"<cmd>lua require('user.utils').run_current_python()<cr>",
			{ noremap = true, silent = true, desc = "Run current python" }
		)
	end, 0)

	-- 配置DAP
	vim.defer_fn(function()
		local dap = require("dap")
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "launch current file",
				program = "${file}",
				console = "integratedTerminal",
				cwd = "${workspaceFolder}",
				args = {},
				pythonPath = require("user.utils").get_workpath_python_resolve(),
			},
			{
				type = "python",
				request = "launch",
				name = "launch current file for args",
				program = "${file}",
				console = "integratedTerminal",
				args = function()
					local input = vim.fn.input("Input args: ")
					return require("user.utils").str2argtable(input)
				end,
				cwd = "${workspaceFolder}",
				pythonPath = require("user.utils").get_workpath_python_resolve(),
			},
		}
	end, 0)
end

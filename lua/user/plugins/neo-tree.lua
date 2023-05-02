return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = function(_, opts)
		opts.window.mappings.i = "open"
		opts.window.mappings["<S-tab>"] = "prev_source"
		opts.window.mappings["<tab>"] = "next_source"
		opts.event_handlers = {
			{
				event = "neo_tree_window_before_open",
				handler = function(_)
					local utils = require("astronvim.utils")
					if utils.is_available("overseer") then
						require("overseer").close()
					end
					if utils.is_available("nvim-dap-ui") then
						require("dapui").close()
					end
					if utils.is_available("undotree") then
						vim.cmd.UndotreeHide()
					end
				end,
			},
		}
		return opts
	end,
}

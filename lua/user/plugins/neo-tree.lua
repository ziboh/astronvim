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
					require("overseer").close()
					if vim.fn.has("win32") == 0 then
						require("dapui").close()
					end
					vim.cmd.UndotreeHide()
				end,
			},
		}
		return opts
	end,
}

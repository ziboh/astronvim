return {
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<cmd>EasyAlign<cr>", desc = "Easy Align", mode = "n" },
			{ "ga", "<cmd>EasyAlign<cr>", desc = "Easy Align", mode = "x" },
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
		opts = {
			window = {
				backdrop = 1,
				width = function()
					return math.min(120, vim.o.columns * 0.75)
				end,
				height = 0.9,
				options = {
					number = false,
					relativenumber = false,
					foldcolumn = "0",
					list = false,
					showbreak = "NONE",
					signcolumn = "no",
				},
			},
			plugins = {
				options = {
					cmdheight = 1,
					laststatus = 0,
				},
			},
			on_open = function() -- disable diagnostics and indent blankline
				vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
				vim.g.diagnostics_mode = 0
				vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[0])
				vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
				vim.g.indent_blankline_enabled = false
			end,
			on_close = function() -- restore diagnostics and indent blankline
				vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
				vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
				vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
			end,
		},
	},
	{
		"akinsho/toggleterm.nvim",
		opts = function(_, opts)
			opts.direction = "horizontal"
			opts.open_mapping = [[<c-t>]]
			opts.size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.3
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.3
				end
			end
			opts.on_exit = function(term)
				if term.direction == "horizontal" then
					term.size = vim.o.lines * 0.3
				elseif term.direction == "vertical" then
					term.size = vim.o.columns * 0.3
				end
			end
			return opts
		end,
		keys = {
			{ "<c-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		},
	},
	{
		"antoinemadec/FixCursorHold.nvim",
		init = function()
			vim.g.cursorhold_updatetime = 100
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			"tami5/sqlite.lua",
			name = "sqlite",
		},
		opts = {
			enable_persistant_history = true,
		},
		keys = {
			{ "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "neoclip" },
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function(_, opts)
			require("nvim-web-devicons").set_default_icon(
				require("astronvim.utils").get_icon("DapBreakpoint"),
				"#ff0000",
				"66"
			)
			require("nvim-web-devicons").set_default_icon(
				require("astronvim.utils").get_icon("DefaultFile"),
				"#6d8086",
				"66"
			)
			require("nvim-web-devicons").set_icon(opts)
		end,
	},
	{
		"ggandor/leap-ast.nvim",
		init = function()
			vim.keymap.set({ "n", "x", "o" }, "m", function()
				require("leap-ast").leap()
			end, { desc = "leap-ash" })
		end,
	},
}

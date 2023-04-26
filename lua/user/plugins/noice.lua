local utils = require("astronvim.utils")
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if not opts.ensure_installed then
				opts.ensure_installed = {}
			end
			if type(opts.ensure_installed) == "table" then
				utils.list_insert_unique(
					opts.ensure_installed,
					{ "bash", "markdown", "markdown_inline", "regex", "vim" }
				)
			end
			return opts
		end,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = function(_, opts)
			opts.background_colour = "#000000"
			return opts
		end,
	},
	{
		"folke/noice.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		init = function()
			vim.g.lsp_handlers_enabled = false
		end,
		opts = {
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				lsp_doc_border = true,
			},
			cmdline = {
				enabled = true,
			},
			lsp = {
				progress = { enabled = false },
				-- hover = { enabled = false },
				-- signature = { enabled = false },
				-- message = { enabled = false },
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- routes
			routes = {
				-- show recording messages
				-- obtained from
				--   https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
				{
					view = "notify",
					filter = {
						event = "msg_showmode",
					},
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					view = "split",
					filter = { event = "msg_show", min_height = 20 },
				},
			},
			-- views
			views = {
				-- view cmdline and popupmenu together
				-- obtained from
				--   https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#display-the-cmdline-and-popupmenu-together
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "66%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
				},
			},
		},
		config = function(_, opts)
			vim.keymap.set("c", "<S-Enter>", function()
				require("noice").redirect(vim.fn.getcmdline())
			end, { desc = "Redirect Cmdline" })
			vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })
			require("noice").setup(opts)
		end,
	},
	{
		"Wansmer/treesj",
		keys = { { "zt", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" } },
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { use_default_keymaps = false },
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		keys = {
			{ "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", desc = "Generate Class" },
			{ "<leader>nf", ":lua require('neogen').generate({ type = 'function' })<CR>", desc = "Generate Function" },
		},
	},
}

local utils = require("astronvim.utils")
return {
	{
		"simrat39/rust-tools.nvim", -- add lsp plugin
		ft = { "rust" },
		init = function()
			astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "rust_analyzer")
		end,
		opts = function()
			local opts = require("astronvim.utils.lsp").config("rust_analyzer")
			local on_attach = opts.on_attach
			local dap = nil
			opts.on_attach = function(_, bufnr)
				local rt = require("rust-tools")
				vim.keymap.set("n", "<C-Space>", rt.hover_actions.hover_actions, { buffer = bufnr })
				-- Code action groups
				vim.keymap.set(
					"n",
					"<Leader>lc",
					rt.code_action_group.code_action_group,
					{ buffer = bufnr, desc = "Code action group" }
				)
				if on_attach then
					on_attach(_, bufnr)
				end
			end

			if vim.fn.has("wsl") == 1 then
				local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.9.1/"
				local codelldb_path = extension_path .. "adapter/codelldb"
				local liblldb_path = extension_path .. "lldb/lib/liblldb"
				local this_os = vim.loop.os_uname().sysname

				-- The path in windows is different
				if this_os:find("Windows") then
					codelldb_path = extension_path .. "\\adapter\\codelldb.exe"
					liblldb_path = extension_path .. "\\lldb\\bin\\liblldb.dll"
				else
					-- The liblldb extension is .so for linux and .dylib for macOS
					liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
				end
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				}
			end

			return {
				server = opts,
				dap = dap,
			}
		end,
		config = function(_, opts)
			require("rust-tools").setup(opts)
		end,
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = function(_, opts)
					opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "codelldb")
				end,
			},
		},
	},
	{
		"Saecki/crates.nvim",
		enabled = true,
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "crates" } } })
					require("crates")
				end,
			})
		end,
		opts = {
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		},
	},
}

-- toggle keymap
return function()
	vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "term://*",
		callback = function()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-]>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			vim.keymap.set("n", "<C-]>", "a", opts)
		end,
	})

	-- dapui keymap
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "dapui_console",
		callback = function()
			---@diagnostic disable-next-line
			local bufname = vim.fn.bufname("%")
			if string.find(bufname, "DAP Console") then
				vim.api.nvim_buf_set_keymap(0, "t", "<ESC>", "<C-\\><C-n>", { noremap = true })
			end
		end,
	})

	local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {}) -- A global group for all your config autocommands
	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "SessionLoadPost",
		group = config_group,
		callback = function()
			vim.defer_fn(require("user.utils").config_python_dap, 0)
		end,
	})
	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "AstroFile",
		group = config_group,
		callback = function()
			vim.defer_fn(require("user.utils").config_python_dap, 0)
		end,
	})

	-- 判断是否是wsl
	if vim.fn.has("wsl") == 1 then
		---@diagnostic disable-next-line:undefined-field
		vim.api.nvim_create_autocmd({ "FocusGained" }, {
			callback = function()
				vim.defer_fn(function()
					local text = vim.fn.getreg("+")
					---@diagnostic disable-next-line: undefined-field
					text = text:gsub("\r", "")
					vim.fn.setreg("+", text)
				end, 0)
			end,
		})
	end
	-- text like documents enable wrap and spell
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "gitcommit", "markdown", "text", "plaintex" },
		group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})

	vim.api.nvim_create_autocmd("BufRead", {
		pattern = { ".zimrc", "bootstrap" },
		callback = function()
			vim.bo.filetype = "zsh"
		end,
	})
	vim.api.nvim_create_augroup("q_close_windows", { clear = true })
end

vim.defer_fn(function()
	local api = vim.api
	api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>or",
		"<cmd>lua require('rust-tools').runnables.runnables()<CR>",
		{ noremap = true, silent = true, desc = "Run current Rust" }
	)
end, 0)

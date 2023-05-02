return {
	{
		"ziboh/Trans.nvim",
		enabled = vim.fn.has("wsl") == 1,
		branch = "v2",
		build = function()
			require("Trans").install()
		end,
		dependencies = { "kkharji/sqlite.lua" },
		keys = {
			-- 可以换成其他你想映射的键
			{ "<leader>tt", mode = { "n", "x" },function() require("Trans").translate() end, desc = " Translate" },
			-- { "<cleader>tk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
			-- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
			{ "<leader>ti",function() require("Trans").translate{ mode = 'i' } end, desc = " Translate From Input" },
		},
		config = function (_,opts)
			require('Trans').setup(opts)
			vim.api.nvim_set_hl( 0,'TransPhonetic', { fg = "#ff9640" } )
		end
	},
}

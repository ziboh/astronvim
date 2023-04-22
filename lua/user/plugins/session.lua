return {
	{
		"Shatur/neovim-session-manager",
		enabled = true,
		event = "UIEnter",
		opts = {
			autosave_ignore_filetypes = {
				"gitcommit",
				"toggleterm",
			},
			autosave_ignore_buftypes = {
				"terminal",
				"quickfix",
				"help",
				"nofile",
			},
			autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
		},
		config = function(_, opts)
			local session = require("session_manager")
			session.setup(opts)
			-- vim.cmd("SessionManager! load_current_dir_session")
		end,
	},
}

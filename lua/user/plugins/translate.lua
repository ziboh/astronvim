return {
	{
		"voldikss/vim-translator",
		enable = true,
		keys = {
			{ "<leader>tw", "<Plug>TranslateW",  desc = "Display translation in a window" },
			{ "<leader>tw", "<Plug>TranslateWV", desc = "Display translation in a window",   mode = { "v" } },
			{ "<leader>tt", "<Plug>Translate",   desc = "Echo translation in the cmdline" },
			{ "<leader>tt", "<Plug>TranslateV",  desc = "Echo translation in the cmdline",   mode = { "v" } },
			{ "<leader>tr", "<Plug>TranslateR",  desc = "Replace the text with translation" },
			{ "<leader>tr", "<Plug>TranslateRV", desc = "Replace the text with translation", mode = { "v" } },
			{ "<leader>tx", "<Plug>TranslateX",  desc = "Translate the text in clipboard" },
		},
	},
	{
		"JuanZoran/Trans.nvim",
		enable = false,
		dependencies = { "kkharji/sqlite.lua" },
		keys = {
			-- 可以换成其他你想映射的键
			{ "<leader>tm",  mode = { "n", "x" },       "<Cmd>Translate<CR>",             desc = " Translate" },
			{ "<cleader>tk", mode = { "n", "x" },       "<Cmd>TransPlay<CR>",             desc = " Auto Play" },
			-- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
			{ "<leader>ti",  "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
		},
		opts = {
			-- Below are the default options, feel free to override what you would like changed
			ui = {
				output_popup_text = "NeoAI",
				input_popup_text = "Prompt",
				width = 30,           -- As percentage eg. 30%
				output_popup_height = 80, -- As percentage eg. 80%
			},
			models = {
				{
					name = "openai",
					model = "gpt-3.5-turbo",
				},
			},
			register_output = {
				["g"] = function(output)
					return output
				end,
				["c"] = require("neoai.utils").extract_code_snippets,
			},
			inject = {
				cutoff_width = 75,
			},
			prompts = {
				context_prompt = function(context)
					return "Hey, I'd like to provide some context for future "
							.. "messages. Here is the code/text that I want to refer "
							.. "to in our upcoming conversations:\n\n"
							.. context
				end,
			},
			open_api_key_env = "OPENAI_API_KEY",
			shortcuts = {
				{
					key = "<leader>as",
					use_context = true,
					prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
					modes = { "v" },
					strip_function = nil,
				},
				{
					key = "<leader>ag",
					use_context = false,
					prompt = function()
						return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
					end,
					modes = { "n" },
					strip_function = nil,
				},
			},
		},
	},
}

return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ac",
				"<cmd>ChatGPT<CR>",
				desc = "Edit with instructions",
				mode = "n",
			},
			{
				"<leader>af",
				"<cmd>ChatGPTActAs<CR>",
				desc = "Chatgpt act as",
				mode = "n",
			},
			{
				"<leader>ai",
				function()
					require("chatgpt").edit_with_instructions()
				end,
				desc = "Edit with instructions",
				mode = "v",
			},
			{
				"<leader>ar",
				":ChatGPTRun ",
				desc = "Run ChatGPT",
				mode = "v",
			},
		},
		opts = {
			chat = {
				keymaps = {
					close = { "<C-c>" },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"Bryley/neoai.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = {
			"NeoAI",
			"NeoAIOpen",
			"NeoAIClose",
			"NeoAIToggle",
			"NeoAIContext",
			"NeoAIContextOpen",
			"NeoAIContextClose",
			"NeoAIInject",
			"NeoAIInjectCode",
			"NeoAIInjectContext",
			"NeoAIInjectContextCode",
		},
		keys = {
			{ "<leader>as", desc = "fix text with AI" },
			{ "<leader>ag", desc = "generate git message" },
			{ "<leader>aa", "<cmd>NeoAIToggle<cr>", desc = "NeoAi toggle" },
			{
				"<leader>ac",
				function()
					local input = vim.fn.input("Input Context: ")
					if input == "" then
						return
					end
					vim.cmd("NeoAIContext " .. input)
				end,
				desc = "NeoAi Context",
				mode = "v",
			},
		},
		opts = {
			-- Below are the default options, feel free to override what you would like changed
			ui = {
				output_popup_text = "NeoAI",
				input_popup_text = "Prompt",
				width = 30, -- As percentage eg. 30%
				output_popup_height = 80, -- As percentage eg. 80%
				submit = "<C-Enter>", -- Key binding to submit the prompt
			},
			models = {
				{
					name = "openai",
					model = "gpt-3.5-turbo",
					params = nil,
				},
			},
			register_output = {
				["m"] = function(output)
					return output
				end,
			},
			inject = {
				cutoff_width = 75,
			},
			prompts = {
				context_prompt = function(context)
					---@diagnostic disable-next-line
					return "Hey, I'd like to provide some context for future "
						.. "messages. Here is the code/text that I want to refer "
						.. "to in our upcoming conversations:\n\n"
						.. context
				end,
			},
			mappings = {
				["select_up"] = "<C-k>",
				["select_down"] = "<C-j>",
			},
			open_api_key_env = "OPENAI_API_KEY",
			openai_api_url = "https://proxy.zzbbhh.sbs/proxy/api.openai.com/v1/chat/completions",
			shortcuts = {
				{
					name = "textify",
					key = "<leader>as",
					desc = "fix text with AI",
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
					name = "gitcommit",
					key = "<leader>ag",
					desc = "generate git commit message",
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

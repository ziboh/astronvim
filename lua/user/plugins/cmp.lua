return {
	{
		"abecodes/tabout.nvim",
		after = "nvim-cmp",
		enabled = true,
		event = "InsertEnter",
		opts = {
			tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
			backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
			act_as_tab = false, -- shift content if tab out is not possible
			act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
			default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
			default_shift_tab = "<C-d>", -- reverse shift default action,
			enable_backwards = true, -- well ...
			completion = true, -- if the tabkey is used in a completion pum
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
			exclude = {}, -- tabout will ignore these filetypes
		},
	},
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			ls.add_snippets("all", {
				s("三元表达式", {
					-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
					i(1, "cond"),
					t(" ? "),
					i(2, "then"),
					t(" : "),
					i(3, "else"),
				}),
			})
			require("plugins.configs.luasnip")(plugin, opts)
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		opts = {
			suggestion = { auto_trigger = true, debounce = 150 },
			filetypes = {
				rust = false,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = function(_, opts)
			local cmp, copilot = require("cmp"), require("copilot.suggestion")
			local snip_status_ok, luasnip = pcall(require, "luasnip")
			if not snip_status_ok then
				return
			end
			-- local function has_words_before()
			-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			-- 	return col ~= 0
			-- 		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			-- end
			if not opts.mapping then
				opts.mapping = {}
			end
			opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
				if copilot.is_visible() then
					copilot.accept()
					-- elseif cmp.visible() then
					-- 	cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
					-- elseif has_words_before() then
					-- 	cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" })

			opts.mapping["<C-x>"] = cmp.mapping(function()
				if copilot.is_visible() then
					copilot.next()
				end
			end)

			opts.mapping["<C-z>"] = cmp.mapping(function()
				if copilot.is_visible() then
					copilot.prev()
				end
			end)

			return opts
		end,
	},
}

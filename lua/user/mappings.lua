return function(maps)
	local ui = require("astronvim.utils.ui")
	local utils = require("astronvim.utils")
	local is_available = utils.is_available
	local sections = {
		a = { desc = "󰚩 Ai" },
		f = { desc = "󰍉 Find" },
		p = { desc = "󰏖 Packages" },
		l = { desc = " LSP" },
		u = { desc = " UI" },
		b = { desc = "󰓩 Buffers" },
		bs = { desc = "󰒺 Sort Buffers" },
		d = { desc = " Debugger" },
		g = { desc = " Git" },
		s = { desc = "󱂬 Session" },
		w = { desc = " Window" },
		x = { desc = " Trouble" },
		t = { desc = "󰗊 Translate" },
		o = { desc = " Task" },
		n = { desc = "󰎔 New" },
		["<tab>"] = { desc = " tab" },
		["resplace"] = { desc = " resplace" },
	}
	-- new
	maps.n["<leader>n"] = sections.n
	maps.n["<leader>nn"] = { "<cmd>enew<cr>", desc = "new file" }

	-- genral
	maps.n["q"] = "<Nop>"
	maps.n["<A-q>"] = "q"
	maps.i["<C-s>"] = { "<esc><cmd>w<cr>a", desc = "save" }

	-- window
	maps.n["<leader>w"] = sections.w
	maps.n["<leader>ww"] = { "<c-w>w", desc = "other window" }
	maps.n["<leader>wd"] = { "<c-w>c", desc = "delete window" }
	maps.n["<leader>wl"] = { "<c-w>v", desc = "spite window right" }
	maps.n["<leader>wj"] = { "<c-w>s", desc = "splite window below" }
	maps.n["<leader>wo"] = { "<c-w>o", desc = "only window" }
	maps.n["<leader>wf"] = { "<c-w>pa", desc = "switch window" }

	-- Spectre
	if is_available("nvim-spectre") then
		maps.v["<leader>s"] = sections["resplace"]
	end

	-- Overseer
	if is_available("overseer.nvim") then
		maps.n["<leader>o"] = sections.o
	else
		maps.n["<leader>o"] = false
	end
	maps.n["<leader>ou"] = { require("user.utils").open_url, desc = "Open url" }

	-- Alpha
	if is_available("alpha-nvim") then
		maps.n["<leader>h"] = false
		maps.n["<leader>;"] = {
			function()
				local wins = vim.api.nvim_tabpage_list_wins(0)
				if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
					vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
				end
				require("alpha").start(false, require("alpha").default_config)
			end,
			desc = "Home Screen",
		}
	end

	-- Mason
	if is_available("mason.nvim") then
		maps.n["<leader>pm"] = false
		maps.n["<leader>lm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
		maps.n["<leader>pM"] = false
		maps.n["<leader>lM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
	end

	-- Session Manager
	maps.n["<leader>s"] = sections.s
	if is_available("neovim-session-manager") then
		maps.n["<leader>sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
		maps.n["<leader>ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
		maps.n["<leader>sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
		maps.n["<leader>sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
		maps.n["<leader>s."] =
		{ "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
		maps.n["<leader>S"] = false
		maps.n["<leader>Sl"] = false
		maps.n["<leader>Ss"] = false
		maps.n["<leader>Sd"] = false
		maps.n["<leader>Sf"] = false
		maps.n["<leader>S."] = false
	end

	-- Trouble
	if is_available("trouble.nvim") or is_available("todo-comments.nvim") then
		maps.n["<leader>x"] = sections.x
	end

	-- Terminal
	if is_available("toggleterm.nvim") then
		if is_available("vim-translator") then
			maps.n["<leader>t"] = sections.t
			maps.v["<leader>t"] = sections.t
		else
			maps.n["<leader>t"] = false
		end
		if vim.fn.executable("lazygit") == 1 then
			maps.n["<leader>gg"] = {
				function()
					--通过获取命令返回的状态码判断当前工作目录是否是git仓库
					local home_dir = vim.fn.expand("$HOME")
					local dotfiles_git = home_dir .. "/.local/share/yadm/repo.git"
					local cmd = nil
					if os.execute("git rev-parse --get-dir") == 0 then
						cmd = "lazygit"
					elseif os.execute("yadm ls-files --error-unmatch " .. vim.fn.expand("%p")) == 0 then
						cmd = "lazygit -w $HOME --git-dir " .. dotfiles_git
					else
						return
					end
					utils.toggle_term_cmd({
						cmd = cmd,
						dir = "git_dir",
						direction = "float",
						size = 1,
						float_opts = {
							border = "none",
							width = 100000,
							height = 100000,
						},
						-- function to run on opening the terminal
						on_open = function(term)
							vim.cmd("startinsert!")
							vim.api.nvim_buf_set_keymap(
								term.bufnr,
								"n",
								"q",
								"<cmd>close<CR>",
								{ noremap = true, silent = true }
							)
						end,
						-- function to run on closing the terminal
						on_close = function(_)
							vim.cmd("startinsert!")
						end,
					})
				end,
				desc = "ToggleTerm lazygit",
			}
			maps.n["<leader>g"] = sections.g
			maps.n["<leader>tl"] = false
		end
		maps.n["<leader>tn"] = false
		maps.n["<leader>tu"] = false
		maps.n["<leader>tt"] = false
		maps.n["<leader>tp"] = false
		maps.n["<leader>th"] = false
		maps.n["<leader>tv"] = false
		maps.n["<leader>tf"] = false
		maps.n["<F7>"] = false
		maps.t["<F7>"] = false
		maps.n["<C-'>"] = false
		maps.t["<C-'>"] = false
		maps.n["<A-1>"] = {
			function()
				require("user.utils").term_toggle("zsh", "horizontal", 100)
			end,
			desc = "ToggleTerm horizontal split",
		}
		maps.n["<A-2>"] = {
			function()
				require("user.utils").term_toggle("zsh", "vertical", 101)
			end,
			desc = "ToggleTerm vertical split",
		}
		maps.n["<A-3>"] = {
			function()
				require("user.utils").term_toggle("zsh", "float", 102)
			end,
			desc = "ToggleTerm float",
		}
		maps.t["<A-1>"] = maps.n["<A-1>"]
		maps.t["<A-2>"] = maps.n["<A-2>"]
		maps.t["<A-3>"] = maps.n["<A-3>"]
	end

	if is_available("telescope.nvim") then
		if is_available("todo-comments.nvim") then
			maps.n["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Find Todo" }
		end
		maps.n["<leader>fT"] = {
			function()
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "Find themes",
		}
		maps.n["<leader>fH"] = { "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" }
		maps.n["<leader><space>"] = {
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		}
		maps.n["<leader>fF"] = false
		maps.n["<leader>ff"] = {
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			desc = "Find all files",
		}
		maps.n["<leader>fp"] = {
			function()
				require("telescope").extensions.projects.projects({})
			end,
			desc = "Find projects",
		}
	end

	-- Manage Buffers
	maps.n["<leader>c"] = {
		"<cmd>Bdelete<cr>",
		desc = "Close buffer",
	}
	maps.n["<leader>C"] = false
	maps.n["]b"] = {
		function()
			require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
		end,
		desc = "Next buffer",
	}
	maps.n["[b"] = {
		function()
			require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
		end,
		desc = "Previous buffer",
	}
	maps.n[">b"] = {
		function()
			require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1)
		end,
		desc = "Move buffer tab right",
	}
	maps.n["<b"] = {
		function()
			require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1))
		end,
		desc = "Move buffer tab left",
	}

	maps.n["<leader>b"] = sections.b
	maps.n["<leader>bo"] = {
		function()
			require("astronvim.utils.buffer").close_all(true)
		end,
		desc = "Close all buffers except current",
	}
	maps.n["<leader>ba"] = {
		function()
			require("astronvim.utils.buffer").close_all()
		end,
		desc = "Close all buffers",
	}
	maps.n["<leader>bD"] = {
		function()
			require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
				require("astronvim.utils.buffer").close(bufnr, true)
			end)
		end,
		desc = "Select buffer from tabline",
	}
	maps.n["<leader>bj"] = {
		function()
			require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
				vim.api.nvim_win_set_buf(0, bufnr)
			end)
		end,
		desc = "Select buffer from tabline",
	}
	maps.n["<leader>bd"] = {
		"<cmd>Bdelete<cr>",
		desc = "Delete current buffer",
	}
	maps.n["<leader>bsm"] = {
		function()
			require("astronvim.utils.buffer").sort("modified")
		end,
		desc = "Sort by modification (buffers)",
	}
	maps.n["<leader>b\\"] = {
		function()
			require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
				vim.cmd.split()
				vim.api.nvim_win_set_buf(0, bufnr)
			end)
		end,
		desc = "Horizontal split buffer from tabline",
	}
	maps.n["<leader>b|"] = {
		function()
			require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
				vim.cmd.vsplit()
				vim.api.nvim_win_set_buf(0, bufnr)
			end)
		end,
		desc = "Vertical split buffer from tabline",
	}
	-- lsp
	maps.n["L"] = { "$", desc = "Move to end of line" }
	maps.n["H"] = { "^", desc = "Move to first non-blank character" }
	maps.v["L"] = { "$h", desc = "Move to end of line" }
	maps.v["H"] = { "^", desc = "Move to first non-blank character" }
	maps.v["H"] = { "^", desc = "Move to first non-blank character" }
	maps.n["M"] = { "J", desc = "Join the current line with the next line" }
	vim.keymap.set("o", "H", "^", { desc = "Move to first non-blank character" })
	vim.keymap.set("o", "L", "$", { desc = "Move to end of line" })

	maps.n["<A-k>"] = { ":m .-2<CR>==", desc = "Increase window height" }
	maps.n["<A-j>"] = { ":m .+1<CR>==", desc = "Decrease window height" }
	maps.i["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" }
	maps.i["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" }
	maps.v["<A-j>"] = { ":m '>+1<CR>gv-gv", desc = "Move line down" }
	maps.v["<A-k>"] = { ":m '<-2<CR>gv-gv", desc = "Move line up" }
	maps.n["<leader>go"] = { require("user.utils").open_github, desc = "Open github" }
	maps.n["<leader><tab>"] = sections["<tab>"]
	maps.n["<leader><tab>f"] = { "<cmd>tabfirst<cr>", desc = "First Tab" }
	maps.n["<leader><tab>l"] = { "<cmd>tablast<cr>", desc = "Last Tab" }
	maps.n["<leader><tab><tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" }
	maps.n["<leader><tab>n"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
	maps.n["]<tab>"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
	maps.n["<leader><tab>p"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
	maps.n["[<tab>"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
	maps.n["<leader><tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }

	maps.n["<leader>un"] = {
		function()
			require("notify").dismiss({ silent = true, pending = true })
		end,
		desc = "Delete all Notifications",
	}
	maps.n["<leader>uN"] = { ui.change_number, desc = "Change line numbering" }

	if is_available("nvim-dap") then
		maps.n["<leader>d"] = sections.d
		maps.n["<F9>"] = {
			function()
				require("persistent-breakpoints.api").toggle_breakpoint()
			end,
			desc = "Debugger: Toggle Breakpoint",
		}
		maps.n["<leader>db"] = { desc = "Breakpoints" }
		maps.n["<leader>dbb"] = {
			function()
				require("persistent-breakpoints.api").set_conditional_breakpoint()
			end,
			desc = "Set Conditional Breakpoint",
		}
		maps.n["<leader>dt"] = {
			function()
				require("persistent-breakpoints.api").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint (F9)",
		}
		maps.n["<leader>dB"] = {
			function()
				require("persistent-breakpoints.api").clear_all_breakpoints()
			end,
			desc = "Clear Breakpoints",
		}
		maps.n["<leader>dbc"] = { function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Clear Breakpoints" }
		maps.n["<leader>dbt"] = { function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
		maps.n["<leader>dU"] = { function() require("dapui").setup() end, desc = "dapui restart" }
	end

	-- neoai
	if is_available("neoai.nvim") then
		maps.n["<leader>a"] = sections.a
		maps.v["<leader>a"] = sections.a
	end
	return maps
end

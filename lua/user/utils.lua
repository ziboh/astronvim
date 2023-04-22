local M = {}
HOME = os.getenv("HOME")

function M.pick_windows()
	local picker = require("window-picker")
	local picked_window_id = picker.pick_window({
				include_current_win = true,
			}) or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end

-- Swap two windows using the awesome window picker
function M.swap_windows()
	local picker = require("window-picker")
	local window = picker.pick_window({
		include_current_win = false,
	})
	---@diagnostic disable-next-line:param-type-mismatch
	local target_buffer = vim.fn.winbufnr(window)
	-- Set the target window to contain current buffer
	---@diagnostic disable-next-line:param-type-mismatch
	vim.api.nvim_win_set_buf(window, 0)
	-- Set current window to contain target buffer
	vim.api.nvim_win_set_buf(0, target_buffer)
end

-- support passing args
M.find_next_start = function(str, cur_idx)
	while cur_idx <= #str and str:sub(cur_idx, cur_idx) == " " do
		cur_idx = cur_idx + 1
	end
	return cur_idx
end

function M.print_table(tab)
	local notify = ""
	for _, value in pairs(tab) do
		notify = notify .. value .. "  "
	end
	print(notify)
end

M.str2argtable = function(str)
	-- trim spaces
	str = string.gsub(str, "^%s*(.-)%s*$", "%1")
	local arg_list = {}

	local start = 1
	local i = 1
	local quote_refs_cnt = 0
	while i <= #str do
		---@diagnostic disable-next-line: undefined-field
		local c = str:sub(i, i)
		if c == '"' then
			quote_refs_cnt = quote_refs_cnt + 1
			start = i
			i = i + 1
			-- find next quote
			---@diagnostic disable-next-line: undefined-field
			while i <= #str and str:sub(i, i) ~= '"' do
				i = i + 1
			end
			if i <= #str then
				quote_refs_cnt = quote_refs_cnt - 1
				---@diagnostic disable-next-line: undefined-field
				arg_list[#arg_list + 1] = str:sub(start, i)
				start = M.find_next_start(str, i + 1)
				i = start
			end
			-- find next start
		elseif c == " " then
			---@diagnostic disable-next-line: undefined-field
			arg_list[#arg_list + 1] = str:sub(start, i - 1)
			start = M.find_next_start(str, i + 1)
			i = start
		else
			i = i + 1
		end
	end

	-- add last arg if possiable
	if start ~= i and quote_refs_cnt == 0 then
		---@diagnostic disable-next-line: undefined-field
		arg_list[#arg_list + 1] = str:sub(start, i)
	end
	return arg_list
end

M.get_workpath_python_resolve = function()
	-- 获取当前工作目录
	local workpath = vim.fn.getcwd()
	-- 判断当前目录是否存在.python_version文件
	local python_version_file = workpath .. "/.python-version"
	local file_exist = io.open(python_version_file, "r") ~= nil

	if file_exist then
		-- 读取python版本号
		local python_version = io.open(python_version_file, "r"):read("*l")
		-- 获取pyenv的安装目录
		local pyenv_root = vim.fn.getenv("PYENV_ROOT")
		return pyenv_root .. "/versions/" .. python_version .. "/bin/python"
	end
	if vim.fn.getenv("PYENV_ROOT") == nil then
		-- 获取python的路径
		local python_path = vim.fn.system("which python")
		return python_path
	end
	return vim.fn.getenv("PYENV_ROOT") .. "/shims/python"
end

function M.run_current_python()
	-- 获取当前工作目录
	local workpath = vim.fn.getcwd()
	-- 获取当前缓冲区文件的路径
	local file_path = vim.fn.expand("%:p")
	vim.cmd("TermExec cmd=" .. [['cd ]] .. workpath .. [[ && python ]] .. file_path .. [[']])
end

function M.delete_other_buffers()
	local current_buf = vim.fn.bufnr()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if bufnr ~= current_buf then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
	end
end

function M.delete_from_ft(filetype)
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local get_filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if get_filetype == filetype then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
	end
end

function M.close_undotree()
	local undotree_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		-- 检查buffer对应的文件类型是否为undotree
		if vim.bo[buf].filetype == "undotree" then
			undotree_win = win
			break
		end
	end

	if undotree_win ~= nil then
		vim.api.nvim_win_close(undotree_win, true)
	end
end

function M.print_bufnr_filetype(ft)
	local str = ""

	-- 遍历所有 buffer
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

		-- 判断是否为 cybu 文件类型
		if filetype == ft then
			str = str .. buf .. "  "
		end
	end
	print(str)
end

M.config_python_dap = function()
	local dap_python = require("dap-python")

	-- Setup dap for python
	local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
	pcall(function()
		dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
	end)

	pcall(function()
		dap_python.test_runner = "unittest"
		dap_python.resolve_python = require("user.utils").get_workpath_python_resolve
	end)
end

-- 将winblend不为0的window设置为0
M.clear_winblend = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local winblend = vim.api.nvim_win_get_option(win, "winblend")
		if winblend ~= 0 then
			vim.api.nvim_win_set_option(win, "winblend", 0)
		end
	end
end

-- 获取当前光标所在的引号字符串
function M.get_quoted_string()
	local _, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- 获取当前行的内容
	local line = vim.api.nvim_get_current_line()

	-- 定义要查找的引号字符
	local quote = nil

	-- 检查光标当前所在位置的字符是否是引号，如果是则设置 quote 变量为该引号字符
	local char = line:sub(col, col)
	if char == "'" or char == '"' then
		quote = char
	end

	-- 如果光标所在位置不是引号，则从当前位置向左右两侧查找第一个引号
	if not quote then
		-- 从当前位置向左找第一个引号
		local i = col - 1
		while i > 0 do
			local c = line:sub(i, i)
			if c == "'" or c == '"' then
				quote = c
				break
			end
			i = i - 1
		end

		-- 如果左侧没有找到引号，则从当前位置向右找第一个引号
		if not quote then
			i = col + 1
			while i <= #line do
				local c = line:sub(i, i)
				if c == "'" or c == '"' then
					quote = c
					break
				end
				i = i + 1
			end
		end
	end

	-- 如果找到了引号，则从两侧查找第一个相同的引号字符所包围的字符串
	if quote then
		local start_col = col
		while start_col > 1 do
			local c = line:sub(start_col - 1, start_col - 1)
			if c == quote and line:sub(start_col - 2, start_col - 2) ~= "\\" then
				break
			end
			start_col = start_col - 1
		end

		local end_col = col
		while end_col < #line do
			local c = line:sub(end_col + 1, end_col + 1)
			if c == quote and line:sub(end_col, end_col) ~= "\\" then
				break
			end
			end_col = end_col + 1
		end

		local word = line:sub(start_col, end_col)
		return word
	else
		return nil
	end
end

function M.open_github()
	local github_url = M.get_quoted_string()
	-- vim.cmd("TermExec cmd=" .. [['gith ]] .. github_url .. [[' open=0]])
	require("toggleterm").exec_command("cmd=" .. [['gith ]] .. github_url .. [[' open=0]], 98)
end

function M.open_url()
	local github_url = M.get_quoted_string()
	-- vim.cmd("TermExec cmd=" .. [['gith ]] .. github_url .. [[' open=0]])
	require("toggleterm").exec_command("cmd=" .. [['chrome ]] .. github_url .. [[' open=0]], 98)
end

M.term_toggle = function(cmd, direction, count)
	local Terminal = require("toggleterm.terminal").Terminal
	local custom_toggle = Terminal:new({
		cmd = cmd,
		hidden = true,
		direction = direction,
		count = count,
	})
	custom_toggle:toggle()
end

return M

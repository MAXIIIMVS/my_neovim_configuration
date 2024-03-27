local present, wk = pcall(require, "which-key")

if not present then
	return
end

local flavors = {
	"catppuccin-mocha",
	"duskfox",
	"catppuccin-macchiato",
	"catppuccin-frappe",
	"nightfox",
	"nordfox",
	"carbonfox",
	"terafox",
	"dayfox",
	"dawnfox",
	"catppuccin-latte",
}

local lualine = require("lualine")
local bufferlineUi = require("bufferline.ui")
-- local telescope = require("telescope")
local telescope_builtins = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local lspsaga_diagnostics = require("lspsaga.diagnostic")
local comment_api = require("Comment.api")
local dapui = require("dapui")
local dap_ui_widgets = require("dap.ui.widgets")
local dap_go = require("dap-go")
local dap = require("dap")
local todo_comments = require("todo-comments")

local function close_buffer(buffer_name)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name ~= "" and vim.fn.bufexists(buf) == 1 and vim.fn.bufname(buf) == buffer_name then
			local is_modified = vim.api.nvim_buf_get_option(buf, "modified")
			if is_modified then
				vim.api.nvim_command("confirm bd")
			else
				vim.api.nvim_buf_delete(buf, { force = true })
			end
			return
		end
	end
end

local function term_debug()
	-- specific to my system
	local gdbfake_file = os.getenv("HOME") .. "/.gdbfake"
	local gdbinit_file = os.getenv("HOME") .. "/.gdbinit"
	local has_gdbfake = vim.fn.filereadable(gdbfake_file) == 1
	if has_gdbfake then
		os.rename(gdbfake_file, gdbinit_file)
	end
	-- until here
	vim.g.termdebug_wide = vim.fn.winwidth(0) > 85
	-- local current_dir = vim.fn.expand("%:p:h")
	vim.cmd("packadd termdebug | startinsert | Termdebug")
	if vim.g.termdebug_wide then
		vim.cmd("wincmd k | wincmd J | resize 10 | wincmd k | wincmd l | wincmd L")
		vim.api.nvim_feedkeys(
			"dashboard -layout variables stack breakpoints  expressions memory registers\n",
			"n",
			true
		)
	else
		vim.api.nvim_feedkeys("dashboard -layout variables\n", "n", true)
	end
	vim.g.termdebug_running = true
	-- vim.api.nvim_feedkeys("layout asm\nlayout regs\n", "n", true)
	-- vim.api.nvim_feedkeys("cd " .. current_dir .. "\n", "n", true)
	-- vim.api.nvim_feedkeys("file " .. current_dir .. "/", "n", true)
	vim.api.nvim_feedkeys("file ", "n", true)
end

local function make(target)
	if target == nil then
		target = ""
	end
	local term_name = " Make Terminal"
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local win_buffer = vim.api.nvim_win_get_buf(win)
		local win_buffer_name = vim.fn.bufname(win_buffer)

		if win_buffer_name == term_name then
			vim.api.nvim_set_current_win(win)
			vim.api.nvim_feedkeys("make " .. target .. "\n", "n", true)
			return
		end
	end
	local buffer_exists = vim.fn.bufexists(term_name)
	if buffer_exists ~= 0 then
		vim.cmd("buffer " .. term_name .. " | startinsert")
		if vim.bo.buftype ~= "terminal" then
			vim.cmd("bd! | startinsert | term")
			vim.cmd("file " .. term_name)
		end
	else
		vim.cmd("split | resize 13 | startinsert | term")
		vim.cmd("file " .. term_name)
	end
	vim.api.nvim_feedkeys("make " .. target .. "\n", "n", true)
end

-- vim.api.nvim_create_autocmd({ "TermClose" }, {
-- 	group = vim.api.nvim_create_augroup("toggle_terminal_close", { clear = true }),
-- 	callback = function()
-- 		if vim.bo.filetype ~= "termdebug" then
-- 			if #vim.api.nvim_list_wins() > 1 then
-- 				vim.cmd("quit!")
-- 			else
-- 				vim.cmd("bd!")
-- 			end
-- 		end
-- 	end,
-- })

local function open_floating_terminal()
	-- shell = vim.env.SHELL
	local current_dir = vim.fn.expand("%:p:h")
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")
	local win_width = math.ceil(width * 0.95 - 4) -- Subtract 4 for the window border
	local win_height = math.ceil(height * 0.95 - 4)
	-- Calculate the starting position of the new floating window
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)
	local config = {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, config)
	vim.api.nvim_win_set_option(win, "winblend", 0)
	vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:NormalFloat,FloatBorder:FloatBorder")
	vim.api.nvim_win_set_option(win, "winhighlight", "Normal:Normal")
	vim.api.nvim_win_set_option(win, "signcolumn", "no")
	vim.api.nvim_win_set_option(win, "number", false)
	vim.api.nvim_win_set_option(win, "relativenumber", false)
	vim.api.nvim_win_set_option(win, "cursorline", false)
	vim.api.nvim_win_set_option(win, "cursorcolumn", false)
	vim.api.nvim_win_set_option(win, "foldcolumn", "0")
	vim.api.nvim_win_set_option(win, "list", false)
	vim.api.nvim_win_set_option(win, "spell", false)
	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
	vim.api.nvim_win_set_option(win, "winhl", "NormalFloat:NormalFloat")
	vim.api.nvim_win_set_option(win, "winhl", "FloatBorder:FloatBorder")
	vim.api.nvim_command("startinsert | e term://" .. current_dir .. "//bash")
end

function responsive_terminal()
	local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
	local buffer_exists = vim.fn.bufexists(term_name)
	if buffer_exists == 0 then
		if vim.fn.winwidth(0) > 85 then
			vim.cmd("vsplit")
		else
			vim.cmd("split | resize 12")
		end
	end
	toggle_terminal()
end

function toggle_terminal()
	if vim.bo.buftype == "terminal" then
		if #vim.api.nvim_list_wins() > 1 then
			vim.api.nvim_command("wincmd p")
		else
			vim.api.nvim_command("bprevious")
		end
		return
	end
	local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local win_buffer = vim.api.nvim_win_get_buf(win)
		local win_buffer_name = vim.fn.bufname(win_buffer)

		if win_buffer_name == term_name then
			vim.api.nvim_set_current_win(win)
			vim.api.nvim_command("startinsert")
			return
		end
	end
	local buffer_exists = vim.fn.bufexists(term_name)
	if buffer_exists ~= 0 then
		vim.cmd("buffer " .. term_name .. " | startinsert")
		if vim.bo.buftype ~= "terminal" then
			vim.cmd("bd! | startinsert | e term://%:p:h//bash | file " .. term_name)
		end
	else
		vim.cmd("startinsert | e term://%:p:h//bash | file " .. term_name)
	end
end

local function get_highlight(group)
	local src = "redir @a | silent! hi " .. group .. " | redir END | let output = @a"
	vim.api.nvim_exec2(src, { output = true })
	local output = vim.fn.getreg("a")
	local list = vim.split(output, "%s+")
	local dict = {}
	for _, item in ipairs(list) do
		if string.find(item, "=") then
			local splited = vim.split(item, "=")
			dict[splited[1]] = splited[2]
		end
	end
	return dict
end

function toggle_tmux_status(useTransparent)
	local bgStyle = ""
	if useTransparent then
		bgStyle = "default"
	else
		local color = get_highlight("lualine_c_normal")["guibg"]
		bgStyle = color ~= nil and color or "#181825"
	end
	local command = string.format(
		"tmux show-option -gq status-style | grep -q 'bg=%s' && tmux set-option -gq status-style bg=%s || tmux set-option -gq status-style bg=%s; tmux refresh-client -S",
		bgStyle,
		bgStyle,
		bgStyle
	)
	local handle = io.popen(command)
	if handle then
		handle:close()
	else
		print("Failed to execute the command.")
	end
end

local function set_tmux_status_color(color)
	local command = string.format(
		"tmux show-option -gq status-style | grep -q 'bg=%s' && tmux set-option -gq status-style bg=%s || tmux set-option -gq status-style bg=%s; tmux refresh-client -S",
		color,
		color,
		color
	)
	local handle = io.popen(command)
	if handle then
		handle:close()
	else
		print("Failed to execute the command.")
	end
end

local function get_git_hash()
	local handle = io.popen("git describe --always")
	if handle then
		local result = handle:read("*a")
		handle:close()
		if result then
			vim.api.nvim_command("let @g = '" .. result .. "'")
		else
			print("Error: Command did not return a result")
		end
	else
		print("Error: Failed to run command")
	end
end

function sync_statusline_with_tmux()
	vim.o.cursorlineopt = vim.g.is_transparent and "number" or "number,line"
	vim.o.cursorline = not vim.g.is_transparent
	local current_background = get_highlight("Normal")["guibg"]
	vim.api.nvim_set_hl(0, "StatusLine", { bg = current_background == nil and "NONE" or "bg" })
	set_tmux_status_color(current_background == nil and "default" or current_background)
	-- vim.o.fillchars = "eob: "
end

local function git_next()
	local handle = io.popen(
		[[
      # Check if we're in a git repository
      if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          echo "Not in a git repository"
          return 1
      fi

      # Check if there are any commits in the current branch
      if ! git rev-parse HEAD > /dev/null 2>&1; then
          echo "No commits in the current branch"
          return 1
      fi

      # Try to get the name of the remote branch that the HEAD points to
      branch=""
      if git rev-parse refs/remotes/origin/HEAD > /dev/null 2>&1; then
          branch=$(git branch -r --points-at refs/remotes/origin/HEAD | grep '\->' | cut -d' ' -f5 | cut -d/ -f2)
      fi

      if [ -z "$branch" ]; then
          # Fallback: Extract branch name in another way
          branch=$(basename $(git rev-parse --show-toplevel)/.git/refs/heads/*)
      fi

      # If there's still no branch or an error, perform another fallback action
      if [ -z "$branch" ]; then
          fallback_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
          next_commit=$(git rev-list --topo-order HEAD..$fallback_branch | tail -1)
          git checkout $next_commit 2>&1
          return
      fi

      # Get the hash of the next commit
      next_commit=""
      next_commit=$(git log --reverse --pretty=%H $branch | grep -A 1 $(git rev-parse HEAD) | tail -n1)

      # If there's no next commit, we're already at the last commit
      if [ -z "$next_commit" ]; then
          echo "Already at the last commit"
          return 1
      fi

      # Try to checkout the next commit, and use the fallback command in case of an error
      git checkout $next_commit 2>&1
    ]],
		"r"
	)
	if handle ~= nil then
		local result = handle:read("*a")
		print(result)
		handle:close()
	else
		print("Failed to execute command")
	end
end

local function git_previous()
	local handle = io.popen([[
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "Not in a git repository"
        return 1
    fi

    # Check if there are any commits in the current branch
    if ! git rev-parse HEAD > /dev/null 2>&1; then
        echo "No commits in the current branch"
        return 1
    fi
    git checkout HEAD^ 2>&1
  ]])
	if handle ~= nil then
		local result = handle:read("*a")
		print(result)
		handle:close()
	else
		print("Failed to execute command")
	end
end

local options = {
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 0, 0 },
		winblend = 0,
	},
	layout = {
		height = { max = 9 },
	},
	popup_mappings = {
		scroll_down = "<C-d>", -- binding to scroll down inside the popup
		scroll_up = "<C-u>", -- binding to scroll up inside the popup
	},
}

wk.setup(options)

-- Normal mode {{{
wk.register({
	["<F1>"] = {
		function()
			local term_name = " Make Terminal"
			close_buffer(term_name)
			local success, _ = pcall(vim.cmd, "silent make")
			if success then
				vim.notify("Build successful!", "info", { title = "Build" })
			end
		end,
		"Build",
	},
	["<F2>"] = {
		function()
			make("valgrind")
		end,
		"Valgrind",
	},
	["<F4>"] = { term_debug, "Start GDB" },
	["<F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
				vim.cmd("call TermDebugSendCommand('c')")
			else
				dap.clear_breakpoints()
				vim.cmd.DapToggleBreakpoint()
				vim.cmd.DapContinue()
			end
		end,
		"Break and Continue/Start DAP",
	},
	["<C-F5>"] = {
		function()
			vim.cmd("silent make run")
		end,
		"Start without debugging",
	},
	["<S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('quit')")
			else
				vim.cmd.DapTerminate()
			end
		end,
		"Stop/Terminate",
	},
	["<C-S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('start')")
			else
				dap.restart()
			end
		end,
		"Restart",
	},
	["<F8>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Evaluate")
			else
				dapui.eval(nil, { enter = true })
			end
		end,
		"Evaluate",
	},
	["<F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
			else
				vim.cmd.DapToggleBreakpoint()
			end
		end,
		"Break",
	},
	["<C-F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('delete')")
			else
				dap.clear_breakpoints()
			end
		end,
		"Delete all breakpoints",
	},
	["<F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Over")
			else
				vim.cmd.DapStepOver()
			end
		end,
		"Step over",
	},
	["<C-F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Until")
			else
				dap.run_to_cursor()
			end
		end,
		"Run to cursor",
	},
	["<F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Step")
			else
				vim.cmd.DapStepInto()
			end
		end,
		"Step into",
	},
	["<S-F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Finish")
			else
				vim.cmd.DapStepOut()
			end
		end,
		"Step out",
	},
	["<F12>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('c')")
			else
				vim.cmd.DapContinue()
			end
		end,
		"Continue/Start DAP",
	},
	["<Nop>"] = { "<Plug>VimwikiRemoveHeaderLevel", "disabled" },
	["-"] = { "<cmd>silent Oil<CR>", "Current directory" },
	-- ["-"] = { "<cmd>e %:p:h<CR>", "Current directory" },
	["_"] = {
		function()
			if vim.bo.buftype == "terminal" then
				vim.cmd("startinsert")
				return
			end
			local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
			local buffer_exists = vim.fn.bufexists(term_name)
			if buffer_exists == 0 then
				vim.cmd("split | resize 12")
			end
			toggle_terminal()
		end,
		"Horizontal Terminal",
	},
	["|"] = {
		function()
			if vim.bo.buftype == "terminal" then
				vim.cmd("startinsert")
				return
			end
			local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
			local buffer_exists = vim.fn.bufexists(term_name)
			if buffer_exists == 0 then
				vim.cmd("vsplit")
			end
			toggle_terminal()
		end,
		"Vertical Terminal",
	},
	["<M-l>"] = { "<CMD>silent NavigatorRight<CR>", "Go to the right window" },
	["<M-h>"] = { "<CMD>silent NavigatorLeft<CR>", "Go to the left window" },
	["<M-k>"] = { "<CMD>silent NavigatorUp<CR>", "Go to the up window" },
	["<M-j>"] = { "<CMD>silent NavigatorDown<CR>", "Go to the down window" },
	["<M-p>"] = { "<CMD>silent NavigatorPrevious<CR>", "Go to the down window" },
	["]<space>"] = { "o<ESC>k", "Insert a blank line below" },
	["[<space>"] = { "O<ESC>j", "Insert a blank line above" },
	["[A"] = {
		function()
			vim.cmd.colorscheme(flavors[1])
		end,
		"First dark theme",
	},
	["[a"] = {
		function()
			local index = #flavors
			for i, f in ipairs(flavors) do
				if vim.g.colors_name == f then
					index = i - 1
					break
				end
			end
			if index < 1 then
				index = #flavors
			end
			vim.cmd.colorscheme(flavors[index])
		end,
		"Previous flavor",
	},
	["]A"] = {
		function()
			vim.cmd.colorscheme(flavors[#flavors])
		end,
		"Last light theme",
	},
	["]a"] = {
		function()
			local index = 1
			for i, f in ipairs(flavors) do
				if vim.g.colors_name == f then
					index = i + 1
					break
				end
			end
			if index > #flavors then
				index = 1
			end
			vim.cmd.colorscheme(flavors[index])
		end,
		"Next flavor",
	},
	["]g"] = { "<cmd>silent Gitsigns next_hunk<CR>", "Jump to the next hunk" },
	["[g"] = { "<cmd>silent Gitsigns prev_hunk<CR>", "Jump to the previous hunk" },
	["[E"] = {
		function()
			lspsaga_diagnostics:goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the previous error",
	},
	["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to the previous diagnostic" },
	["]E"] = {
		function()
			lspsaga_diagnostics:goto_next({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the next error",
	},
	["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to the next diagnostic" },
	["[n"] = {
		todo_comments.jump_prev,
		"Previous todo comment",
	},
	["]n"] = {
		todo_comments.jump_next,
		"Next todo comment",
	},
	["[p"] = { "<cmd>pu!<CR>", "Paste above current line" },
	["]p"] = { "<cmd>pu<CR>", "Paste below current line" },
	["[q"] = { "<cmd>silent cprev<CR>", "Show the previous item in QuickFix" },
	["]q"] = { "<cmd>silent cnext<CR>", "Show the next item in QuickFix" },
	["[Q"] = { "<cmd>silent cfirst<CR>", "See the first item in QuickFix" },
	["]Q"] = { "<cmd>silent clast<CR>", "See the last item in QuickFix" },
	["]x"] = { "<cmd>BufferLineCloseRight<CR>", "Close all the buffers to the right" },
	["[x"] = { "<cmd>BufferLineCloseLeft<CR>", "Close all the buffers to the left" },
	["<M-Left>"] = { "<cmd>vertical resize -1<CR>", "Increase window width" },
	["<M-Right>"] = { "<cmd>vertical resize +1<CR>", "Decrease window width" },
	["<M-Up>"] = { "<cmd>resize -1<CR>", "Increase window height" },
	["<M-Down>"] = { "<cmd>resize +1<CR>", "Decrease window height" },
	["<C-s>"] = { "<cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<cmd>wall<CR>", "Save all buffers" },
	["<M-t>"] = { toggle_terminal, "Terminal" },
	[";"] = {
		name = "Quick",
		[";"] = { "<cmd>Bdelete<CR>", "Delete current buffer" },
		["<space>"] = { "<cmd>Telescope<CR>", "Telescope" },
		["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "Go to 1st buffer" },
		["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Go to 2nd buffer" },
		["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Go to 3rd buffer" },
		["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Go to 4th buffer" },
		["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Go to 5th buffer" },
		["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Go to 6th buffer" },
		["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Go to 7th buffer" },
		["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Go to 8th buffer" },
		["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Go to 9th buffer" },
		-- b = { "<cmd>Telescope buffers previewer=false<CR>", "List open buffers" },
		b = {
			function()
				telescope_builtins.buffers(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"List open buffers",
		},
		c = {
			function()
				telescope_builtins.colorscheme(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Lists available color schemes",
		},
		d = {
			"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
			"Browse current directory",
		},
		D = { "<cmd>Telescope file_browser<CR>", "File/Folder browser from root" },
		e = { "<cmd>silent Telescope diagnostics<CR>", "List diagnostics" },
		E = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
		f = { "<cmd>Telescope find_files<CR>", "Find files" },
		F = { "<cmd>Telescope git_files<CR>", "Fuzzy search for files tracked by Git" },
		g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
		G = { "<cmd>Telescope grep_string<CR>", "Grep string under the cursor" },
		H = { ":Man ", "Show man pages", silent = false },
		h = {
			function()
				telescope_builtins.help_tags(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Show help tags",
		},
		l = { "<cmd>Telescope lsp_document_symbols<CR>", "Show LSP document symbols" },
		m = { make, "Make" },
		n = { "<cmd>TodoTelescope<CR>", "See notes/todos..." },
		o = { "<cmd>silent !xdg-open %<CR>", "Open the current file" },
		O = { "<cmd>silent !xdg-open %:p:h<CR>", "Open the current directory" },
		p = { "<cmd>silent Telescope zoxide list<CR>", "Projects" },
		q = { vim.cmd.q, "Close current window" },
		Q = { vim.cmd.qall, "Close all windows" },
		-- r = { "<cmd>Telescope oldfiles previewer=false<CR>", "Show recently opened files" },
		r = {
			function()
				telescope_builtins.oldfiles(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Show recently opened files",
		},
		-- NOTE: the next two substitution commands depend on vim-abolish
		s = {
			[[:S/<C-r><C-w>/<C-r><C-w>/g<Left><left>]],
			"Change the word under the cursor in the line",
			silent = false,
		},
		S = {
			[[:%S/<C-r><C-w>/<C-r><C-w>/g<Left><left>]],
			"Change the word under the cursor in the whole file",
			silent = false,
		},
		T = { "<cmd>Telescope tags<CR>", "tags" },
		t = {
			name = "tmux",
			c = { "<cmd>silent !tmux clock-mode<CR>", "Clock" },
			F = {
				function()
					local p = vim.fn.expand("%:p:h")
					local s = vim.fn.escape(
						[[ silent !tmux display-popup -w 90% -h 85% -d ]] .. p .. [[ -E "tmux new-session -A -s bash "]],
						"%"
					)
					vim.cmd(s)
				end,
				"Floating Bash (tmux)",
			},
			f = {
				function()
					local p = vim.fn.expand("%:p:h")
					local s = vim.fn.escape("silent !tmux display-popup -w 90% -h 85%  -E -d " .. p, "%")
					vim.cmd(s)
				end,
				"Floating Bash (terminal)",
			},
			g = { "<cmd>silent !tmux new-window 'lazygit'<CR>", "LazyGit" },
			H = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -c " .. filepath)
				end,
				"Horizontal split normal",
			},
			h = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -l 12 -c " .. filepath)
				end,
				"Horizontal split",
			},
			t = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux new-window -c " .. filepath)
				end,
				"Window",
			},
			v = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -h -c " .. filepath)
				end,
				"Vertical split",
			},
		},
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		x = { vim.cmd.NvimTreeToggle, "Nvim Tree" },
		X = { "<cmd>silent call ToggleNetrw()<CR>", "Netrw" },
		z = { "<cmd>ZenMode<CR>", "Toggle Zen Mode" },
		-- Z = { "<C-w>|<C-w>_", "Maximize the window" },
	},
	[","] = {
		name = "Miscellaneous",
		[","] = { open_floating_terminal, "Floating terminal" },
		["1"] = { "1<C-w>w", "Go to 1st window" },
		["2"] = { "2<C-w>w", "Go to 2nd window" },
		["3"] = { "3<C-w>w", "Go to 3rd window" },
		["4"] = { "4<C-w>w", "Go to 4th window" },
		["5"] = { "5<C-w>w", "Go to 5th window" },
		["6"] = { "6<C-w>w", "Go to 6th window" },
		["7"] = { "7<C-w>w", "Go to 7th window" },
		["8"] = { "8<C-w>w", "Go to 8th window" },
		["9"] = { "9<C-w>w", "Go to 9th window" },
		a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add a folder to workspace" },
		D = { term_debug, "Debug with GDB" },
		d = { "<cmd>silent Dashboard<CR>", "dashboard" },
		f = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
		H = { "<cmd>silent Telescope keymaps<CR>", "Keymaps" },
		h = { "<cmd>WhichKey<CR>", "Which Key" },
		m = { "<cmd>messages<CR>", "messages" },
		q = { "<cmd>tabclose<CR>", "Close tab" },
		r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove a folder from workspace" },
		S = {
			[[:%s/<c-r><C-w>/<C-r><C-w>/gi<left><left><left>]],
			"Substitute the word in the whole file (ignore case)",
			silent = false,
		},
		s = {
			[[:s/<C-r><C-w>/<C-r><C-w>/gi<left><left><left>]],
			"Substitute the word in this line (ignore case)",
			silent = false,
		},
		T = { "<cmd>tabnew<CR>", "Create an empty tab" },
		t = {
			name = "Terminal",
			f = {
				open_floating_terminal,
				"Float",
			},
			h = {
				function()
					if vim.bo.buftype == "terminal" then
						vim.cmd("startinsert")
						return
					end
					local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
					local buffer_exists = vim.fn.bufexists(term_name)
					if buffer_exists == 0 then
						vim.cmd("split | resize 12")
					end
					toggle_terminal()
				end,
				"Horizontal",
			},
			v = {
				function()
					if vim.bo.buftype == "terminal" then
						vim.cmd("startinsert")
						return
					end
					local term_name = vim.fn.expand("%:p:h") .. " (Terminal)"
					local buffer_exists = vim.fn.bufexists(term_name)
					if buffer_exists == 0 then
						vim.cmd("vsplit")
					end
					toggle_terminal()
				end,
				"Vertical",
			},
			t = {
				function()
					local current_dir = vim.fn.expand("%:p:h")
					vim.api.nvim_command("tabnew | startinsert | e term://" .. current_dir .. "//bash")
				end,
				"Tab",
			},
		},
		x = { "<cmd>BufferLinePickClose<CR>", "Pick a buffer to close" },
	},
	g = {
		-- d = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
		P = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition" },
		h = { "<cmd>Lspsaga finder def+ref+imp<CR>", "Show the definition, reference, implementation..." },
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		r = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
	},
	j = { "gj", "Down" },
	K = { "<cmd>Lspsaga hover_doc<CR>", "Hover info" },
	k = { "gk", "Up" },
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	name = "Groups",
	["<space>"] = { responsive_terminal, "Automatic vertical/horizontal terminal" },
	b = {
		name = "Buffer",
		a = { "<cmd>bufdo bd<CR>", "Close all buffers" },
		d = { "<cmd>silent bd<CR>", "Close this buffer" },
		e = {
			function()
				local current_buffer = vim.api.nvim_get_current_buf()
				local buffers = vim.api.nvim_list_bufs()

				for _, buf in ipairs(buffers) do
					if buf ~= current_buffer and vim.api.nvim_buf_is_valid(buf) then
						local buf_name = vim.api.nvim_buf_get_name(buf)
						local buf_loaded = vim.api.nvim_buf_is_loaded(buf)
						local buf_empty = buf_loaded and vim.api.nvim_buf_line_count(buf) <= 1

						if buf_empty and buf_name == "" then
							vim.api.nvim_buf_delete(buf, { force = true })
						end
					end
				end
				bufferlineUi.refresh()
			end,
			"Close empty buffers (not current one)",
		},
		O = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "Close other buffers" },
		o = { "<cmd>BufferLineCloseOthers<CR>|'\"", "Close other buffers" },
		h = { "<cmd>BufferLineMovePrev<CR>", "Move the buffer to the previous position" },
		l = { "<cmd>BufferLineMoveNext<CR>", "Move the buffer to the next position" },
		P = { "<cmd>BufferLineTogglePin<CR>", "Pin buffer" },
		p = { "<cmd>BufferLinePick<CR>", "Pick a Buffer" },
	},
	c = {
		name = "Calendar",
		c = { "<cmd>Calendar<CR>", "Main Calendar (view month)" },
		y = { "<cmd>Calendar -view=year<CR>", "View Year" },
		w = { "<cmd>Calendar -view=week<CR>", "View Week" },
		d = { "<cmd>Calendar -view=day<CR>", "View Day" },
		D = { "<cmd>Calendar -view=days<CR>", "View Days" },
		t = { "<cmd>Calendar -view=clock<CR>", "View Clock" },
		O = { "<cmd>silent !open https://calendar.google.com/calendar/u/0/r/tasks<CR>", "Open Google Tasks" },
		o = { "<cmd>silent !open https://calendar.google.com/calendar/u/0/r<CR>", "Open Google Calendar" },
		g = { ":Calendar ", "Go to date (mm dd yyyy)", silent = false },
	},
	d = {
		name = "Debugger",
		A = { "<cmd>call TermDebugSendCommand('layout regs asm')<CR>", "GDB: disassembly and registers" },
		a = { "<cmd>silent Asm<CR>", "GDB: Disassembly" },
		-- B = { "<cmd>silent Clear<CR>", "GDB: remove breakpoint" },
		B = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('delete')")
				else
					dap.clear_breakpoints()
				end
			end,
			"Delete all breakpoints",
		},
		b = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Break")
				else
					vim.cmd.DapToggleBreakpoint()
				end
			end,
			"Break",
		},
		C = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Until")
				else
					dap.run_to_cursor()
				end
			end,
			"Run to cursor",
		},
		c = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('c')")
				else
					vim.cmd.DapContinue()
				end
			end,
			"Continue",
		},
		d = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('down 1')")
				else
					dap.down()
				end
			end,
			"Go down in current stacktrace without stepping",
		},
		e = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Evaluate")
				else
					dapui.eval(nil, { enter = true })
				end
			end,
			"Evaluate expression",
		},
		f = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Finish")
				else
					vim.cmd.DapStepOut()
				end
			end,
			"Step out (finish)",
		},
		g = {
			name = "Go programming language",
			t = {
				function()
					dap_go.debug_test()
				end,
				"Debug go test",
			},
			l = {
				function()
					dap_go.debug_last()
				end,
				"Debug last go test",
			},
		},
		h = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Hover",
		},
		j = {
			dap.goto_,
			"Jump to a specific line or line under cursor",
		},
		l = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('info locals')")
				else
					dap_ui_widgets.sidebar(dap_ui_widgets.scopes).open()
				end
			end,
			"Locals",
		},
		N = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('reverse-step')")
				else
					dap.step_back()
				end
			end,
			"Step back",
		},
		n = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Over")
				else
					vim.cmd.DapStepOver()
				end
			end,
			"Step over",
		},
		p = {
			dap.pause,
			"Pause the thread",
		},
		R = {
			vim.cmd.DapToggleRepl,
			"Toggle repl",
		},
		-- R = {
		-- 	name = "GDB: Reverse",
		-- 	c = { "<cmd>call TermDebugSendCommand('reverse-continue')<CR>", "Continue" },
		-- 	n = { "<cmd>call TermDebugSendCommand('reverse-next')<CR>", "Next" },
		-- 	R = { "<cmd>call TermDebugSendCommand('record stop')<CR>", "Stop" },
		-- 	r = { "<cmd>call TermDebugSendCommand('record')<CR>", "Record" },
		-- 	-- S = { "<cmd>call TermDebugSendCommand('reverse-search')<CR>", "Record" },
		-- 	s = { "<cmd>call TermDebugSendCommand('reverse-step')<CR>", "Step" },
		-- },
		r = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('start')")
				else
					dap.restart()
				end
			end,
			"Restart",
		},
		q = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('quit')")
				else
					vim.cmd.DapTerminate()
				end
			end,
			"Stop/Terminate",
		},
		s = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Step")
				else
					vim.cmd.DapStepInto()
				end
			end,
			"Step into",
		},
		t = { "<cmd>call TermDebugSendCommand('bt')<CR>", "GDB: Bracktrace" },
		u = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('up 1')")
				else
					dap.up()
				end
			end,
			"Go up in current stacktrace without stepping",
		},
		w = {
			function()
				dapui.elements.watches.add(nil)
			end,
			"Watch the word under cursor",
		},
	},
	e = {
		name = "Emojis & Icons",
		e = { "<cmd>silent Telescope emoji<CR>", "Emojis" },
		i = { "<cmd>silent Telescope glyph<CR>", "Glyphs" },
	},
	g = {
		name = "Git",
		["["] = {
			function()
				git_previous()
				vim.cmd("G log -1 --stat")
			end,
			"Checkout previous commit",
		},
		["]"] = {
			function()
				git_next()
				vim.cmd("G log -1 --stat")
			end,
			"checkout next commit",
		},
		A = { "<cmd>silent G restore --staged %<CR>", "Unstage the file" },
		a = { "<cmd>silent G add %<CR>", "Stage the file" },
		B = { "<cmd>Gitsigns blame_line<CR>", "Blame on the current line" },
		b = { "<cmd>silent G blame<CR>", "Blame on the current file" },
		C = { ":silent G checkout ", "Checkout", silent = false },
		c = { "<cmd>silent vertical G commit<CR>", "Commit" },
		D = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent Gvdiffsplit! HEAD~")
				else
					vim.cmd("silent Gdiffsplit! HEAD~")
				end
			end,
			"Diff with previous commit",
		},
		d = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent Gvdiffsplit!")
				else
					vim.cmd("silent Gdiffsplit!")
				end
			end,
			"Diff with previous commit",
		},
		E = {
			"<cmd>silent vertical G commit --amend<CR>",
			"Amend (edit) commit with staged changes",
		},
		f = { "<cmd>silent G fetch<CR>", "Fetch" },
		g = { ":Ggrep! -q ", "Grep", silent = false },
		h = { get_git_hash, "copy current git hash to g register" },
		L = { "<cmd>silent G log --stat<CR>", "Log with stats" },
		l = { "<cmd>silent G log --decorate<CR>", "Log" },
		n = { "<cmd>silent G! difftool HEAD~1 | cfirst <CR>", "changed files since last commit" },
		o = { "<cmd>silent GBrowse<CR>", "Open in the browser" },
		P = { "<cmd>silent G push<CR>", "Push" },
		p = { "<cmd>silent G pull<CR>", "Pull" },
		R = { "<cmd>silent G checkout HEAD -- %<CR>", "Reset the file" },
		r = {
			"<cmd>Gitsigns reset_hunk<CR>",
			"Reset the lines of the hunk at the cursor position, or all lines in the given range.",
		},
		s = { "<cmd>silent Git<CR>", "Status" },
		S = { ":silent G switch ", "Switch", silent = false },
		T = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
		t = { "<cmd>GitTimeLaps<CR>", "Show time lapse of the file" },
		w = {
			name = "worktree",
			a = { ":G worktree add ", "add", silent = false },
			L = { ":G worktree lock ", "Lock", silent = false },
			l = { "<cmd>G worktree list<CR>", "List" },
			m = { ":G worktree move ", "Move", silent = false },
			p = { "<cmd>G worktree prune<CR>", "prune" },
			R = { ":G worktree repair ", "Repair", silent = false },
			r = { ":G worktree remove ", "remove", silent = false },
			u = { ":G worktree unlock ", "Unlock", silent = false },
		},
	},
	l = {
		name = "LSP",
		I = { ":LspInstall ", "Install", silent = false },
		i = { "<cmd>LspInfo<CR>", "Info" },
		L = { "<cmd>LspLog<CR>", "Log" },
		r = { ":LspRestart ", "Restart", silent = false },
		S = { ":LspStart ", "Start", silent = false },
		s = { ":LspStop ", "Stop", silent = false },
		u = { ":LspUninstall ", "Uninstall", silent = false },
	},
	m = {
		name = "Make",
		a = {
			function()
				make("all")
			end,
			"All",
		},
		B = {
			function()
				make("clean-build")
			end,
			"Clean build",
		},
		b = {
			function()
				make("build")
			end,
			"Build",
		},
		c = {
			function()
				make("clean")
			end,
			"Clean",
		},
		d = {
			function()
				make("debug")
			end,
			"Debug",
		},
		g = {
			function()
				make("generate")
			end,
			"Generate",
		},
		h = {
			function()
				make("help")
			end,
			"Help",
		},
		i = {
			function()
				make("install")
			end,
			"Install",
		},
		r = {
			function()
				make("run")
			end,
			"Run",
		},
		t = {
			function()
				make("test")
			end,
			"Test",
		},
		v = {
			function()
				make("valgrind")
			end,
			"valgrind",
		},
		w = {
			function()
				make("watch")
			end,
			"Watch",
		},
	},
	s = {
		name = "Session",
		m = { "<cmd>Obsession<CR>", "Make a session" },
		d = { "<cmd>Obsession!<CR>", "Delete the session" },
	},
	t = {
		name = "Toggle",
		b = {
			function()
				vim.o.background = vim.o.background == "dark" and "light" or "dark"
			end,
			"Background color (Light/dark) ",
		},
		C = {
			"<cmd>ColorizerToggle<CR>",
			"Colorizer",
		},
		c = {
			function()
				vim.wo.colorcolumn = vim.wo.colorcolumn == "" and "79" or ""
			end,
			"Color column",
		},
		D = { "<cmd>silent DBUIToggle<CR>", "DB UI" },
		d = { "<cmd>silent lua ToggleDiagnostics()<CR>", "diagnostics" },
		g = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "git line blame" },
		h = {
			"<cmd>TSToggle highlight<CR>",
			"Treesitter highlight",
		},
		l = {
			function()
				vim.o.cursorline = not vim.o.cursorline
				if vim.o.cursorline then
					vim.o.cursorlineopt = "number,line"
				else
					vim.o.cursorlineopt = "number"
				end
			end,
			"Cursor line",
		},
		o = { "<cmd>Lspsaga outline<CR>", "Outline" },
		q = {
			function()
				local qf_exists = false
				for _, win in pairs(vim.fn.getwininfo()) do
					if win["quickfix"] == 1 then
						qf_exists = true
					end
				end
				if qf_exists == true then
					vim.cmd("cclose")
					return
				end
				if not vim.tbl_isempty(vim.fn.getqflist()) then
					vim.cmd("copen")
				end
			end,
			"Quick fix",
		},
		r = {
			function()
				vim.wo.relativenumber = not vim.wo.relativenumber
			end,
			"Relative number",
		},
		S = { "<cmd>silent Sleuth<CR>", "sleuth" },
		s = {
			function()
				if vim.o.statusline == "" then
					---@diagnostic disable-next-line: missing-fields
					lualine.hide({ unhide = true })
				else
					---@diagnostic disable-next-line: missing-fields
					lualine.hide({ unhide = false })
					vim.o.statusline = "" -- "" is same as "%t %m"
				end
			end,
			"Statusline/lualine",
		},
		t = {
			function()
				-- if not vim.g.is_transparent and vim.o.background == "light" then
				-- 	return
				-- end
				vim.g.is_transparent = not vim.g.is_transparent
				-- local tokyonight_options = require("tokyonight.config").options
				-- tokyonight_options.transparent = vim.g.is_transparent
				-- local osaka_options = require("solarized-osaka.config").options
				-- osaka_options.transparent = vim.g.is_transparent
				local catppuccin = require("catppuccin")
				catppuccin.options.transparent_background = vim.g.is_transparent
				local nightfox = require("nightfox.config")
				nightfox.options.transparent = vim.g.is_transparent
				catppuccin.compile()
				vim.cmd("NightfoxCompile")
				vim.cmd.colorscheme(vim.g.colors_name)
			end,
			"Transparency",
		},
		u = { vim.cmd.UndotreeToggle, "Undotree" },
		-- w = {
		--  function()
		--    vim.wo.winbar = vim.wo.winbar == "" and require("lspsaga.symbolwinbar"):get_winbar() or ""
		--  end,
		--  "winbar",
		-- },
		z = {
			"<cmd>ZenMode<CR>",
			"Zen mode",
		},
	},
	w = {
		name = "Window",
		d = { "<cmd>windo diffthis<CR>", "Show the difference between 2 windows" },
		D = { "<cmd>windo diffoff<CR>", "Hide the difference between 2 windows" },
		h = { "<C-w>h", "Move the right window" },
		j = { "<C-w>j", "Move the window below" },
		k = { "<C-w>k", "Move the window above" },
		l = { "<C-w>l", "Move the left window" },
		o = { "<cmd>only<CR>", "close all other windows" },
		s = { "<cmd>windo set scrollbind<CR>", "Set scrollbind" },
		S = { "<cmd>windo set scrollbind!<CR>", "Unset scrollbind" },
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })

wk.register({
	c = { "<cmd>silent CatppuccinCompile<CR>", "Recompile Catppuccin" },
	d = { "<cmd>silent Dashboard<CR>", "Dashboard" },
	f = {
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format buffer",
	},
	s = { "<cmd>silent so %<CR>", "Source the file" },
	w = {
		name = "VimWiki",
		l = { "<cmd>VimwikiTOC<CR>", "Create or update the Table of Contents for the current wiki file" },
	},
	x = {
		"<cmd>silent !chmod u+x %<CR>",
		"Make the file executable for the (u)ser , don't change (g)roup and (o)ther permissions",
	},
}, { prefix = "<leader>", noremap = true, silent = true, nowait = true })
-- }}}

-- Insert mode {{{
wk.register({
	["<F1>"] = {
		function()
			local term_name = " Make Terminal"
			close_buffer(term_name)
			local success, _ = pcall(vim.cmd, "silent make")
			if success then
				vim.notify("Build successful!", "info", { title = "Build" })
			end
		end,
		"Build",
	},
	["<F2>"] = {
		function()
			make("valgrind")
		end,
		"Valgrind",
	},
	["<F4>"] = { term_debug, "Start GDB" },
	["<F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
				vim.cmd("call TermDebugSendCommand('c')")
			else
				dap.clear_breakpoints()
				vim.cmd.DapToggleBreakpoint()
				vim.cmd.DapContinue()
			end
		end,
		"Break and Continue/Start DAP",
	},
	["<C-F5>"] = {
		function()
			vim.cmd("silent make run")
		end,
		"Start without debugging",
	},
	["<S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('quit')")
			else
				vim.cmd.DapTerminate()
			end
		end,
		"Stop/Terminate",
	},
	["<C-S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('start')")
			else
				dap.restart()
			end
		end,
		"Restart",
	},
	["<F8>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Evaluate")
			else
				dapui.eval(nil, { enter = true })
			end
		end,
		"Evaluate",
	},
	["<F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
			else
				vim.cmd.DapToggleBreakpoint()
			end
		end,
		"Break",
	},
	["<C-F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('delete')")
			else
				dap.clear_breakpoints()
			end
		end,
		"Delete all breakpoints",
	},
	["<F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Over")
			else
				vim.cmd.DapStepOver()
			end
		end,
		"Step over",
	},
	["<C-F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Until")
			else
				dap.run_to_cursor()
			end
		end,
		"Run to cursor",
	},
	["<F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Step")
			else
				vim.cmd.StepInto()
			end
		end,
		"Step into",
	},
	["<S-F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Finish")
			else
				vim.cmd.DapStepOut()
			end
		end,
		"Step out",
	},
	["<F12>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('c')")
			else
				vim.cmd.DapContinue()
			end
		end,
		"Continue/Start DAP",
	},
	["<C-_>"] = {
		function()
			comment_api.toggle.linewise.current()
		end,
		"Comment/uncomment the line",
	},
	["<C-s>"] = { "<ESC><ESC><cmd>silent update<CR>", "Save buffer" },
	["<C-x>"] = {
		name = "Insert expand",
		["<C-D>"] = "Complete defined identifiers",
		["<C-E>"] = "Scroll up",
		["<C-F>"] = "Complete file names",
		["<C-I>"] = "Complete identifiers",
		["<C-K>"] = "Complete identifiers from dictionary",
		["<C-L>"] = "Complete whole lines",
		["<C-N>"] = "Next completion",
		["<C-O>"] = "Omni completion",
		["<C-P>"] = "Previous completion",
		["<C-S>"] = "Spelling suggestions",
		["<C-T>"] = "Complete identifiers from thesaurus",
		["<C-Y>"] = "Scroll down",
		["<C-U>"] = "Complete with 'completefunc'",
		["<C-V>"] = "Complete like in : command line",
		["<C-Z>"] = "Stop completion, keeping the text as-is",
		["<C-]>"] = "Complete tags",
		["s"] = "Spelling suggestions",
	},
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<M-l>"] = { "<ESC><CMD>silent NavigatorRight<CR>", "Go to the right window" },
	["<M-h>"] = { "<ESC><CMD>silent NavigatorLeft<CR>", "Go to the left window" },
	["<M-k>"] = { "<ESC><CMD>silent NavigatorUp<CR>", "Go to the up window" },
	["<M-j>"] = { "<ESC><CMD>silent NavigatorDown<CR>", "Go to the down window" },
	["<C-k>"] = { "<C-o>C", "Delete to the end of the line" },
	-- ["<C-r>"] = { "<cmd>Telescope registers<CR>", "show registers" },
}, { prefix = "", mode = "i", noremap = true, silent = true, nowait = true })
-- }}}

-- Visual mode {{{
wk.register({
	[";"] = {
		name = "Quick",
		S = { 'y:%S/<C-r>"/<C-r>"/g<LEFT><LEFT>', "Change the selection in whole document", silent = false },
		s = { 'y:S/<C-r>"/<C-r>"/g<LEFT><LEFT>', "Change the selection in this line", silent = false },
	},
	-- ["."] = { ":normal.<CR>", "Repeat previous action" },
	-- ["p"] = { '"_dP', "Paste over currently selected text without yanking it" }, -- this causes pasting in select mode (when using snippets)
	["<"] = { "<gv", "Indent left" },
	[">"] = { ">gv", "Indent right" },
	["<C-_>"] = {
		function()
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			comment_api.toggle.linewise(vim.fn.visualmode())
		end,
		"Comment/uncomment selected lines",
	},
	["<C-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
}, { prefix = "", mode = "v", noremap = true, silent = true, nowait = true })

wk.register({
	g = {
		name = "Git",
		w = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
		W = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
	},
}, { prefix = "<space>", mode = "v", noremap = true, silent = true, nowait = true })
-- }}}

-- Select mode {{{
wk.register({
	["<M-d>"] = { "<ESC>dei", "Delete the next word" },
	["<M-b>"] = { "<ESC>bi", "Move back" },
	["<M-f>"] = { "<ESC>ei", "Move forward" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<C-a>"] = { "<ESC>I", "Go to the beginning of line" },
	["<C-e>"] = { "<ESC>A", "Go to the end of line" },
	["<C-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
}, { prefix = "", mode = "s", noremap = true, silent = true, nowait = true })
-- }}}

-- terminal mode {{{
wk.register({
	["<Esc>"] = { "<C-\\><C-n>", "quit insert mode" },
	["<F1>"] = {
		function()
			local term_name = " Make Terminal"
			close_buffer(term_name)
			local success, _ = pcall(vim.cmd, "silent make")
			if success then
				vim.notify("Build successful!", "info", { title = "Build" })
			end
		end,
		"Build",
	},
	["<F2>"] = {
		function()
			make("valgrind")
		end,
		"Valgrind",
	},
	["<F4>"] = { term_debug, "Start GDB" },
	["<F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
				vim.cmd("call TermDebugSendCommand('c')")
			else
				dap.clear_breakpoints()
				vim.cmd.DapToggleBreakpoint()
				vim.cmd.DapContinue()
			end
		end,
		"Break and Continue/Start DAP",
	},
	["<C-F5>"] = {
		function()
			vim.cmd("silent make run")
		end,
		"Start without debugging",
	},
	["<S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('quit')")
			else
				vim.cmd.DapTerminate()
			end
		end,
		"Stop/Terminate",
	},
	["<C-S-F5>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('start')")
			else
				dap.restart()
			end
		end,
		"Restart",
	},
	["<F8>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Evaluate")
			else
				dapui.eval(nil, { enter = true })
			end
		end,
		"Evaluate",
	},
	["<F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Break")
			else
				vim.cmd.DapToggleBreakpoint()
			end
		end,
		"Break",
	},
	["<C-F9>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('delete')")
			else
				dap.clear_breakpoints()
			end
		end,
		"Delete all breakpoints",
	},
	["<F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Over")
			else
				vim.cmd.DapStepOver()
			end
		end,
		"Step over",
	},
	["<C-F10>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Until")
			else
				dap.run_to_cursor()
			end
		end,
		"Run to cursor",
	},
	["<F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Step")
			else
				vim.cmd.StepInto()
			end
		end,
		"Step into",
	},
	["<S-F11>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Finish")
			else
				vim.cmd.DapStepOut()
			end
		end,
		"Step out",
	},
	["<F12>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("call TermDebugSendCommand('c')")
			else
				vim.cmd.DapContinue()
			end
		end,
		"Continue/Start DAP",
	},
	-- ["<M-t>"] = { "<C-\\><C-n><c-o>", "go back" },
	["<M-t>"] = {
		function()
			if #vim.api.nvim_list_wins() > 1 then
				vim.api.nvim_command("wincmd p")
			else
				vim.api.nvim_command("bprevious")
			end
		end,
		"Go back",
	},
	["<C-s>"] = { "<C-\\><C-n><C-w>s <cmd>startinsert | term<CR>", "Horizontal split" },
	["<C-v>"] = { "<C-\\><C-n><C-w>v<cmd>startinsert | term<CR>", "Vertical split" },
	["<M-l>"] = { "<CMD>silent NavigatorRight<CR>", "Go to the right window" },
	["<M-h>"] = { "<CMD>silent NavigatorLeft<CR>", "Go to the left window" },
	["<M-k>"] = { "<CMD>silent NavigatorUp<CR>", "Go to the up window" },
	["<M-j>"] = { "<CMD>silent NavigatorDown<CR>", "Go to the down window" },
	["<M-Left>"] = { "<cmd>vertical resize +2<CR>", "Increase window width" },
	["<M-Right>"] = { "<cmd>vertical resize -1<CR>", "Decrease window width" },
	["<M-Down>"] = { "<cmd>resize -1<CR>", "Increase window height" },
	["<M-Up>"] = { "<cmd>resize +1<CR>", "Decrease window height" },
}, { prefix = "", mode = "t", noremap = true, silent = true, nowait = true })
-- }}}

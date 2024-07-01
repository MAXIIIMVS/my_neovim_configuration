local wk = require("which-key")

-- Normal mode {{{
wk.register({
	["<Nop>"] = { "<Plug>VimwikiRemoveHeaderLevel", "disabled" },
	["-"] = { "<cmd>silent Oil<CR>", "Current directory" },
	["_"] = {
		function()
			vim.cmd("ToggleTerm direction=horizontal")
		end,
		"Horizontal",
	},
	["|"] = {
		function()
			vim.cmd("ToggleTerm size=80 direction=vertical")
		end,
		"Vertical",
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
	["]h"] = { "<cmd>silent Gitsigns next_hunk<CR>", "Jump to the next hunk" },
	["[h"] = { "<cmd>silent Gitsigns prev_hunk<CR>", "Jump to the previous hunk" },
	["[E"] = {
		function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the previous error",
	},
	["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to the previous diagnostic" },
	["]E"] = {
		function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the next error",
	},
	["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to the next diagnostic" },
	["[t"] = {
		require("todo-comments").jump_prev,
		"Previous todo comment",
	},
	["]t"] = {
		require("todo-comments").jump_next,
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
	["<M-t>"] = {
		function()
			vim.cmd("ToggleTerm")
		end,
		"horizontal terminal",
	},
	[";"] = {
		name = "Quick",
		[";"] = { "<cmd>lua require('mini.bufremove').delete()<CR>", "Delete current buffer" },
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
		b = {
			function()
				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"List open buffers",
		},
		c = {
			function()
				require("telescope.builtin").colorscheme(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"List available color schemes",
		},
		D = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
		d = { "<cmd>silent Telescope diagnostics<CR>", "List diagnostics" },
		f = { "<cmd>Telescope find_files<CR>", "Find files" },
		F = { "<cmd>Telescope git_files<CR>", "Fuzzy search for files tracked by Git" },
		g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
		G = { "<cmd>Telescope grep_string<CR>", "Grep string under the cursor" },
		H = { ":Man ", "Show man pages", silent = false },
		h = {
			function()
				require("telescope.builtin").help_tags(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"Show help tags",
		},
		l = { "<cmd>Telescope lsp_document_symbols<CR>", "Show LSP document symbols" },
		m = { vim.cmd.make, "Make" },
		o = { "<cmd>silent !xdg-open %<CR>", "Open the current file" },
		O = { "<cmd>silent !xdg-open %:p:h<CR>", "Open the current directory" },
		p = { "<cmd>silent Telescope zoxide list<CR>", "Projects" },
		q = { vim.cmd.q, "Close current window" },
		Q = { vim.cmd.qall, "Close all windows" },
		r = {
			function()
				require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({
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
		t = { "<cmd>TodoTelescope<CR>", "See notes/todos..." },
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		-- NOTE: you have to change the ;x keymap for netrw, if you change the next
		-- line
		x = { "<cmd>silent call ToggleNetrw()<CR>", "Netrw" },
		y = { "<cmd>silent lua require('tfm').open()<CR>", "Yazi" },
		z = { "<cmd>ZenMode<CR>", "Toggle Zen Mode" },
		Z = { "<C-w>|<C-w>_", "Maximize the window" },
	},
	[","] = {
		name = "Miscellaneous",
		[","] = {
			function()
				vim.cmd("ToggleTerm size=160 direction=float dir=%:p:h")
			end,
			"Floating Terminal",
		},
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
		F = { ":find ", "find a file", silent = false },
		f = { "<cmd>silent Telescope filetypes<CR>", "Set filetype" },
		H = { "<cmd>silent Telescope keymaps<CR>", "Keymaps" },
		h = { "<cmd>WhichKey<CR>", "Which Key" },
		m = { "<cmd>messages<CR>", "Messages" },
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
		x = { "<cmd>BufferLinePickClose<CR>", "Pick a buffer to close" },
	},
	g = {
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
		h = { "<cmd>Lspsaga finder def+ref+imp<CR>", "Show the definition, reference, implementation..." },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
		P = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition" },
		R = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Show references" },
		S = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature" },
		y = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition" },
	},
	K = { "<cmd>Lspsaga hover_doc<CR>", "Hover info" },
	k = { "gk", "Up" },
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	name = "Groups",
	["<space>"] = {
		function()
			vim.cmd("ToggleTerm direction=tab dir=%:p:h")
		end,
		"Tab",
	},
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
				require("bufferline.ui").refresh()
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
					require("dap").clear_breakpoints()
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
					require("dap").run_to_cursor()
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
					require("dap").down()
				end
			end,
			"Go down in current stacktrace without stepping",
		},
		e = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("Evaluate")
				else
					require("dapui").eval(nil, { enter = true })
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
					require("dap-go").debug_test()
				end,
				"Debug go test",
			},
			l = {
				function()
					require("dap-go").debug_last()
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
			require("dap").goto_,
			"Jump to a specific line or line under cursor",
		},
		l = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('info locals')")
				else
					require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).open()
				end
			end,
			"Locals",
		},
		N = {
			function()
				if vim.g.termdebug_running then
					vim.cmd("call TermDebugSendCommand('reverse-step')")
				else
					require("dap").step_back()
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
			require("dap").pause,
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
					require("dap").restart()
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
					require("dap").up()
				end
			end,
			"Go up in current stacktrace without stepping",
		},
		w = {
			function()
				require("dapui").elements.watches.add(nil)
			end,
			"Watch the word under cursor",
		},
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
		c = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent vertical G commit")
				else
					vim.cmd("silent G commit")
				end
			end,
			"Commit",
		},
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
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent vertical G commit --amend")
				else
					vim.cmd("silent G commit --amend")
				end
			end,
			"Amend (edit) commit with staged changes",
		},
		f = { "<cmd>silent G fetch<CR>", "Fetch" },
		g = { ":Ggrep! -q ", "Grep", silent = false },
		h = { get_git_hash, "copy current git hash to g register" },
		L = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent vertical G log --stat")
				else
					vim.cmd("silent G log --stat")
				end
			end,
			"Log with stats",
		},
		l = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent vertical G log --decorate")
				else
					vim.cmd("silent G log --decorate")
				end
			end,
			"Log",
		},
		n = { "<cmd>silent G! difftool HEAD~1 | cfirst <CR>", "changed files since last commit" },
		o = { "<cmd>silent GBrowse<CR>", "Open in the browser" },
		P = { "<cmd>silent G push<CR>", "Push" },
		p = { "<cmd>silent G pull<CR>", "Pull" },
		R = { "<cmd>silent G checkout HEAD -- %<CR>", "Reset the file" },
		r = {
			"<cmd>Gitsigns reset_hunk<CR>",
			"Reset the lines of the hunk at the cursor position, or all lines in the given range.",
		},
		s = {
			function()
				if vim.fn.winwidth(0) > 85 then
					vim.cmd("silent vertical Git")
				else
					vim.cmd("silent Git")
				end
			end,
			"Status",
		},
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
				vim.cmd('TermExec cmd="make all"')
			end,
			"All",
		},
		B = {
			function()
				vim.cmd('TermExec cmd="make clean-build"')
			end,
			"Clean build",
		},
		b = {
			function()
				vim.cmd('TermExec cmd="make build"')
			end,
			"Build",
		},
		c = {
			function()
				vim.cmd('TermExec cmd="make clean"')
			end,
			"Clean",
		},
		d = {
			function()
				vim.cmd('TermExec cmd="make debug"')
			end,
			"Debug",
		},
		g = {
			function()
				vim.cmd('TermExec cmd="make generate"')
			end,
			"Debug",
		},
		h = {
			function()
				vim.cmd('TermExec cmd="make help"')
			end,
			"Help",
		},
		i = {
			function()
				vim.cmd('TermExec cmd="make install"')
			end,
			"Install",
		},
		r = {
			function()
				vim.cmd('TermExec cmd="make run"')
			end,
			"Run",
		},
		t = {
			function()
				vim.cmd('TermExec cmd="make test"')
			end,
			"Test",
		},
		v = {
			function()
				vim.cmd('TermExec cmd="make valgrind"')
			end,
			"valgrind",
		},
		w = {
			function()
				vim.cmd('TermExec cmd="make watch"')
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
		i = {
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			"Inlay Hints",
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
					require("lualine").hide({ unhide = true })
				else
					require("lualine").hide({ unhide = false })
					vim.o.statusline = "" -- "" is same as "%t %m"
				end
			end,
			"Statusline/lualine",
		},
		t = {
			function()
				local found = false
				for _, f in ipairs(flavors) do
					if vim.g.colors_name == f then
						found = true
						break
					end
				end
				if not found then
					return
				end
				vim.g.is_transparent = not vim.g.is_transparent
				local tokyonight_options = require("tokyonight.config").options
				tokyonight_options.transparent = vim.g.is_transparent
				tokyonight_options.styles = {
					floats = vim.g.is_transparent and "transparent" or "normal",
					sidebars = vim.g.is_transparent and "transparent" or "normal",
				}
				local osaka_options = require("solarized-osaka.config").options
				osaka_options.styles = {
					floats = vim.g.is_transparent and "transparent" or "normal",
					sidebars = vim.g.is_transparent and "transparent" or "normal",
				}
				osaka_options.transparent = vim.g.is_transparent
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
	n = { "<cmd>silent noa w<CR>", "Save with no actions" },
	s = { "<cmd>silent so %<CR>", "Source the file" },
	t = { "<cmd>silent ToggleTermSendCurrentLine<CR>", "Send current line to terminal" },
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
	["<leader>T"] = { "<cmd>ToggleTermSendVisualSelection<CR>", "Send selection to terminal" },
	["<leader>t"] = { "<cmd>ToggleTermSendVisualLines<CR>", "Send lines to terminal" },
	[";"] = {
		name = "Quick",
		S = { 'y:%S/<C-r>"/<C-r>"/g<LEFT><LEFT>', "Change the selection in whole document", silent = false },
		s = { 'y:S/<C-r>"/<C-r>"/g<LEFT><LEFT>', "Change the selection in this line", silent = false },
		q = { "<cmd>q<CR>", "quit" },
	},
	-- ["."] = { ":normal.<CR>", "Repeat previous action" },
	-- ["p"] = { '"_dP', "Paste over currently selected text without yanking it" }, -- this causes pasting in select mode (when using snippets)
	["<"] = { "<gv", "Indent left" },
	[">"] = { ">gv", "Indent right" },
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
	["<C-l>"] = { "<Plug>CapsLockEnable", "Toggle capslock" },
	["<C-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
}, { prefix = "", mode = "s", noremap = true, silent = true, nowait = true })
-- }}}

-- terminal mode {{{
wk.register({
	["<Esc>"] = { "<C-\\><C-n>", "Quit insert mode" },
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

wk.register({
	["<F1>"] = {
		function()
			vim.cmd("TermExec cmd=make")
		end,
		"Build",
	},
	["<F2>"] = {
		function()
			vim.cmd('TermExec cmd="make valgrind"')
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
				require("dap").clear_breakpoints()
				vim.cmd.DapToggleBreakpoint()
				vim.cmd.DapContinue()
			end
		end,
		"Break and Continue/Start DAP",
	},
	["<C-F5>"] = {
		function()
			vim.cmd('TermExec cmd="make run"')
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
				require("dap").restart()
			end
		end,
		"Restart",
	},
	["<F8>"] = {
		function()
			if vim.g.termdebug_running then
				vim.cmd("Evaluate")
			else
				require("dapui").eval(nil, { enter = true })
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
				require("dap").clear_breakpoints()
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
				require("dap").run_to_cursor()
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
}, { prefix = "", mode = { "n", "v", "t", "i" }, noremap = true, silent = true, nowait = true })

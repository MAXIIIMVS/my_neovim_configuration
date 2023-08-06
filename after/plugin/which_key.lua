local present, wk = pcall(require, "which-key")

if not present then
	return
end

local catppuccin = require("catppuccin")
local lualine = require("lualine")
-- local telescope = require("telescope")
local telescope_builtins = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local lspsaga_diagnostics = require("lspsaga.diagnostic")
local comment_api = require("Comment.api")
local dap_ui_widgets = require("dap.ui.widgets")
local dap_go = require("dap-go")
local dap = require("dap")
-- local dapui = require("dapui")
-- local opts = { noremap = true, silent = true, silent = true, nowait = true }

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
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
}

wk.setup(options)

-- Normal mode {{{
wk.register({
	-- ["<M-l>"] = { "<C-w>l", "Go to the right window" },
	-- ["<M-h>"] = { "<C-w>h", "Go to the left window" },
	-- ["<M-k>"] = { "<C-w>k", "Go to the up window" },
	-- ["<M-j>"] = { "<C-w>j", "Go to the down window" },
	["<M-l>"] = { "<CMD>NavigatorRight<CR>", "Go to the right window" },
	["<M-h>"] = { "<CMD>NavigatorLeft<CR>", "Go to the left window" },
	["<M-k>"] = { "<CMD>NavigatorUp<CR>", "Go to the up window" },
	["<M-j>"] = { "<CMD>NavigatorDown<CR>", "Go to the down window" },
	["<M-p>"] = { "<CMD>NavigatorPrevious<CR>", "Go to the down window" },
	["]<space>"] = { "o<ESC>k", "Insert a blank line below" },
	["[<space>"] = { "O<ESC>j", "Insert a blank line above" },
	["[b"] = { vim.cmd.bprev, "Go to previous buffer" },
	["]b"] = { vim.cmd.bnext, "Go to next buffer" },
	["]B"] = { "<cmd>BufferLineMoveNext<CR>", "Move the buffer to the next position" },
	["[B"] = { "<cmd>BufferLineMovePrev<CR>", "Move the buffer to the previous position" },
	["]c"] = { "<cmd>silent Gitsigns next_hunk<CR>", "Jump to the next hunk" },
	["[c"] = { ":Gitsigns prev_hunk<CR>", "Jump to the previous hunk" },
	["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to the previous diagnostic" },
	["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to the next diagnostic" },
	["[E"] = {
		function()
			lspsaga_diagnostics:goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the previous error",
	},
	["]E"] = {
		function()
			lspsaga_diagnostics:goto_next({ severity = vim.diagnostic.severity.ERROR })
		end,
		"Jump to the next error",
	},
	["[l"] = { "<cmd>silent lprev<CR>", "See the previous item in local list" },
	["]l"] = { "<cmd>silent lnext<CR>", "See the next item in local list" },
	["[L"] = { "<cmd>silent lfirst<CR>", "See the first item in local list" },
	["]L"] = { "<cmd>silent llast<CR>", "See the last item in local list" },
	["[p"] = { "<cmd>pu!<CR>", "Paste above current line" },
	["]p"] = { "<cmd>pu<CR>", "Paste below current line" },
	["[q"] = { "<cmd>silent cprev<CR>", "Show the previous item in QuickFix" },
	["]q"] = { "<cmd>silent cnext<CR>", "Show the next item in QuickFix" },
	["[Q"] = { "<cmd>silent cfirst<CR>", "See the first item in QuickFix" },
	["]Q"] = { "<cmd>silent clast<CR>", "See the last item in QuickFix" },
	["]x"] = { "<cmd>BufferLineCloseRight<CR>", "Close all the buffers to the right" },
	["[x"] = { "<cmd>BufferLineCloseLeft<CR>", "Close all the buffers to the left" },
	["<C-Left>"] = { ":vertical resize +2<CR>", "Increase window width" },
	["<C-Right>"] = { ":vertical resize -1<CR>", "Decrease window width" },
	["<C-Up>"] = { ":resize -1<CR>", "Increase window height" },
	["<C-Down>"] = { ":resize +1<CR>", "Decrease window height" },
	["<c-s>"] = { "<cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<cmd>wall<CR>", "Save all buffers" },
	-- ["<c-\\>"] = { "<cmd>Lspsaga term_toggle<CR>", "lspsaga terminal" },
	["<c-\\>"] = {
		function()
			local p = vim.fn.expand("%:p:h")
			local cmd = "ToggleTerm direction=horizontal dir=" .. p
			vim.cmd(cmd)
		end,
		"horizaontal terminal",
	},
	[";"] = {
		name = "Quick",
		[";"] = { ":Bdelete<CR>", "Delete current buffer" },
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
			"File/Folder browser",
		},
		D = { "<cmd>Telescope file_browser<CR>", "File/Folder browser from root" },
		e = { "<cmd>silent Telescope diagnostics<CR>", "List diagnostics" },
		E = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
		f = { "<cmd>Telescope find_files<CR>", "Find files" },
		F = { "<cmd>Telescope git_files <CR>", "Fuzzy search for files tracked by Git" },
		g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
		G = { "<cmd>Telescope grep_string<CR>", "Grep string under the cursor" },
		h = {
			function()
				telescope_builtins.help_tags(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Show help tags",
		},
		-- H = { "<cmd>Telescope man_pages previewer=false<CR>", "Show help tags" },
		H = {
			function()
				telescope_builtins.man_pages(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Show man pages",
		},
		i = { "<cmd>silent Telescope glyph<CR>", "Glyph icon" },
		I = { "<cmd>silent Telescope emoji<CR>", "Emoji icon" },
		m = { "<cmd>make<CR>", "make" },
		o = { "<cmd>silent !xdg-open %<CR>", "Open the current file" },
		O = { "<cmd>silent !xdg-open %:p:h<CR>", "Open the current directory" },
		q = { vim.cmd.q, "close current window" },
		Q = { vim.cmd.qall, "close all windows" },
		-- r = { "<cmd>Telescope oldfiles previewer=false<CR>", "Show recently opened files" },
		r = {
			function()
				telescope_builtins.oldfiles(telescope_themes.get_dropdown({
					previewer = false,
				}))
			end,
			"Show recently opened files",
		},
		s = {
			[[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			"Change the word under the cursor in the line",
			silent = false,
		},
		S = {
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			"Change the word under the cursor in the whole file",
			silent = false,
		},
		t = {
			name = "tmux",
			t = { "<cmd>silent !tmux clock-mode<CR>", "clock" },
			w = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux new-window -c " .. filepath)
				end,
				"window",
			},
			H = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -c " .. filepath)
				end,
				"horizontal split normal",
			},
			h = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -l 9 -c " .. filepath)
				end,
				"horizontal split",
			},
			v = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -h -c " .. filepath)
				end,
				"vertical split",
			},
			g = { "<cmd>silent !tmux new-window 'lazygit'<CR>", "lazygit" },
			B = {
				function()
					local p = vim.fn.expand("%:p:h")
					local s = vim.fn.escape(
						[[ silent !tmux display-popup -w 90% -h 85% -d ]] .. p .. [[ -E "tmux new-session -A -s bash "]],
						"%"
					)
					vim.cmd(s)
				end,
				"pop-up bash (tmux)",
			},
			b = {
				function()
					local p = vim.fn.expand("%:p:h")
					local s = vim.fn.escape("silent !tmux display-popup -w 90% -h 85%  -E -d " .. p, "%")
					vim.cmd(s)
				end,
				"pop-up bash (terminal)",
			},
		},
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		x = { vim.cmd.NvimTreeToggle, "Nvim Tree" },
		X = { "<cmd>silent call ToggleNetrw()<CR>", "Netrw" },
		z = { "<cmd>ZenMode<CR>", "Toggle Zen Mode" },
		Z = { "<c-w>|<c-w>_", "Maximize the window" },
		["<space>"] = { "<cmd>Telescope<CR>", "Telescope builtins" },
	},
	[","] = {
		name = "Miscellaneous",
		["1"] = { "1<c-w>w", "Go to 1st window" },
		["2"] = { "2<c-w>w", "Go to 2nd window" },
		["3"] = { "3<c-w>w", "Go to 3rd window" },
		["4"] = { "4<c-w>w", "Go to 4th window" },
		["5"] = { "5<c-w>w", "Go to 5th window" },
		["6"] = { "6<c-w>w", "Go to 6th window" },
		["7"] = { "7<c-w>w", "Go to 7th window" },
		["8"] = { "8<c-w>w", "Go to 8th window" },
		["9"] = { "9<c-w>w", "Go to 9th window" },
		a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add a folder to workspace" },
		f = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
		i = { "<cmd>silent LspInfo<CR>", "See LSP info" },
		r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove a folder from workspace" },
		x = { "<cmd>BufferLinePickClose<CR>", "Pick a buffer to close" },
	},
	-- TODO: add the next keybinding if the bug is fixed
	-- ["z="] = { "<cmd>silent Telescope spell_suggest<CR>", "show spell suggestions" },
	-- ['"'] = { "<cmd>Telescope registers<CR>", "registers" },
	-- ["'"] = { "<cmd>Telescope marks<CR>", "marks" },
	-- ["q:"] = { "<cmd>Telescope command_history<CR>", "command history" },
	g = {
		-- d = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition in a floating windows" },
		h = { "<cmd>Lspsaga finder def+ref+imp<CR>", "Show the definition, reference, implementation..." },
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		r = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
	},
	K = { "<cmd>silent Lspsaga hover_doc ++quiet<CR><silent>", "Hover info" },
	-- n = { "nzt", "show next search result" },
	-- N = { "Nzt", "show previous search result" },
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	name = "Groups",
	m = {
		name = "make",
		a = {
			":make all<CR>",
			"all",
		},
		B = {
			":make clean-build<CR>",
			"clean build",
		},
		b = {
			":make build<CR>",
			"build",
		},
		c = {
			":make clean<CR>",
			"clean",
		},
		d = {
			":make docs<CR>",
			"generate docs",
		},
		G = {
			":make clean && make generate && make build<CR>",
			"clean, generate and build again",
		},
		g = {
			":make generate<CR>",
			"generate",
		},
		h = {
			":make help<CR>",
			"help",
		},
		i = {
			":make install<CR>",
			"install",
		},
		r = {
			":make run<CR>",
			"run",
		},
		t = {
			":make test<CR>",
			"run",
		},
		w = {
			":make watch<CR>",
			"watch",
		},
	},
	s = {
		name = "Session",
		m = { "<cmd>Obsession<CR>", "Make a session" },
		d = { "<cmd>Obsession!<CR>", "Delete the session" },
	},
	d = {
		name = "debugger",
		b = {
			vim.cmd.DapToggleBreakpoint,
			"toggle breakpoint",
		},
		C = {
			dap.run_to_cursor,
			"run to cursor",
		},
		c = {
			vim.cmd.DapContinue,
			"continue",
		},
		d = {
			dap.down,
			"go down in current stacktrace without stepping",
		},
		e = {
			require("dapui").eval,
			"evaluate expression",
		},
		g = {
			name = "Go programming language",
			t = {
				function()
					dap_go.debug_test()
				end,
				"debug go test",
			},
			l = {
				function()
					dap_go.debug_last()
				end,
				"debug last go test",
			},
		},
		h = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"hover",
		},
		j = {
			dap.goto_,
			"jump to a specific line or line under cursor",
		},
		s = {
			vim.cmd.DapStepInto,
			"step into",
		},
		N = {
			dap.step_back,
			"step back",
		},
		n = {
			vim.cmd.DapStepOver,
			"step over (next)",
		},
		f = {
			vim.cmd.DapStepOut,
			"step out (finish)",
		},
		p = {
			dap.pause,
			"pause the thread",
		},
		R = {
			dap.restart,
			"restart the current session",
		},
		r = {
			vim.cmd.DapToggleRepl,
			"toggle repl",
		},
		l = {
			function()
				local sidebar = dap_ui_widgets.sidebar(dap_ui_widgets.scopes)
				sidebar.open()
			end,
			"Open locals window",
		},
		q = {
			vim.cmd.DapTerminate,
			"Quit",
		},
		u = {
			dap.up,
			"go up in current stacktrace without stepping",
		},
	},
	t = {
		name = "Toggle",
		b = {
			name = "background",
			c = {
				function()
					vim.o.background = vim.o.background == "dark" and "light" or "dark"
					catppuccin.options.transparent_background = not catppuccin.options.transparent_background
					vim.cmd.colorscheme(vim.g.colors_name)
					catppuccin.compile()
				end,
				"light/dark background color",
			},
			t = {
				function()
					local transparent = not catppuccin.options.transparent_background
					catppuccin.options.transparent_background = transparent
					catppuccin.options.dim_inactive = {
						enabled = not transparent,
						shade = "dark",
						percentage = 0.65,
					}
					catppuccin.compile()
					-- vim.o.cursorlineopt = catppuccin.options.transparent_background and "number" or "number,line"
					vim.cmd.colorscheme(vim.g.colors_name)
				end,
				"transparency",
			},
		},
		c = {
			function()
				vim.wo.colorcolumn = vim.wo.colorcolumn == "" and "79" or ""
			end,
			"color column",
		},
		-- d = { "<cmd>silent Dashboard<CR>", "dashboard" },
		d = { ":silent lua ToggleDiagnostics()<CR>", "diagnostics" },
		g = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "git line blame" },
		h = {
			function()
				vim.o.cmdheight = vim.o.cmdheight == 0 and 1 or 0
			end,
			"cmdheight 0 or 1",
		},
		l = { "<cmd>Telescope ToggleLSP<CR>", "LSP" },
		o = { "<cmd>Lspsaga outline<CR>", "outline" },
		p = {
			"<cmd>BufferLineTogglePin<CR>",
			"pin buffer",
		},
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
			"toggle quick fix",
		},
		r = {
			function()
				vim.wo.relativenumber = not vim.wo.relativenumber
			end,
			"relative number",
		},
		s = {
			function()
				if vim.o.statusline == "" then
					lualine.hide({ unhide = true })
				else
					lualine.hide({ unhide = false })
					vim.o.statusline = "" -- "" is same as "%t %m"
				end
			end,
			"statusline/lualine",
		},
		-- T = {
		-- 	name = "treesitter",
		-- 	h = { "<cmd>TSToggle highlight<CR>", "highlight" },
		-- 	i = { "<cmd>TSToggle indent<CR>", "indent" },
		-- },
		--
		t = {
			name = "terminal",
			h = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm direction=horizontal dir=" .. p
					vim.cmd(cmd)
				end,
				"horizontal",
			},
			v = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm size=80 direction=vertical dir=" .. p
					vim.cmd(cmd)
				end,
				"vertical",
			},
			f = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm size=160 direction=float dir=" .. p
					vim.cmd(cmd)
				end,
				"float",
			},
			t = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm direction=tab dir=" .. p
					vim.cmd(cmd)
				end,
				"tab",
			},
		},
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		-- w = {
		--  function()
		--    vim.wo.winbar = vim.wo.winbar == "" and require("lspsaga.symbolwinbar"):get_winbar() or ""
		--  end,
		--  "winbar",
		-- },
		z = {
			"<cmd>ZenMode<CR>",
			"zen mode",
		},
	},
	b = {
		name = "buffer",
		a = { "<cmd>bufdo bd<CR>", "close all buffers" },
		d = { "<cmd>silent bd<CR>", "close this buffer" },
		-- o = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "close other buffers" },
		o = { "<cmd>BufferLineCloseOthers<CR>|'\"", "close other buffers" },
	},
	c = {
		name = "Calendar",
		c = { "<cmd>Calendar<CR>", "Main Calendar (view month)" },
		y = { "<cmd>Calendar -view=year<CR>", "View Year" },
		w = { "<cmd>Calendar -view=week<CR>", "View Week" },
		d = { "<cmd>Calendar -view=day<CR>", "View Day" },
		D = { "<cmd>Calendar -view=days<CR>", "View Days" },
		t = { "<cmd>Calendar -view=clock<CR>", "View Clock" },
		o = { "<cmd>silent !open https://calendar.google.com/calendar/u/0/r<CR>", "Open Google Calendar" },
		g = { ":Calendar ", "Go to date (mm dd yyyy)" },
	},
	g = {
		name = "Git",
		["["] = { "<cmd>silent G checkout HEAD^<CR>", "Checkout previous commit" },
		["]"] = {
			"<cmd>silent !git checkout $(git rev-list --topo-order HEAD..$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') | tail -1)<CR>",
			"Checkout next commit",
		},
		a = {
			"<cmd>silent vertical G commit --amend<CR>",
			"Amend commit with staged changes",
		},
		B = { "<cmd>Gitsigns blame_line<CR>", "Blame on the current line" },
		b = { "<cmd>silent G blame<CR>", "Blame on the current file" },
		C = { ":silent G checkout ", "Checkout", silent = false },
		c = { "<cmd>silent vertical G commit<CR>", "Commit" },
		D = { "<cmd>silent Gvdiffsplit HEAD~<CR>", "Diff with previous commit" },
		d = { "<cmd>silent Gvdiffsplit<CR>", "Diff" },
		f = { "<cmd>silent G fetch<CR>", "Fetch" },
		g = { ":Ggrep! -q ", "Grep" },
		h = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
		H = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
		l = { "<cmd>silent vertical G log --stat<CR>", "Log with stats" },
		L = { "<cmd>silent vertical G log --decorate<CR>", "Log" },
		o = { "<cmd>silent GBrowse<CR>", "Open in the browser" },
		P = { "<cmd>silent G push<CR>", "Push" },
		p = { "<cmd>silent G pull<CR>", "Pull" },
		r = {
			"<cmd>Gitsigns reset_hunk<CR>",
			"Reset the lines of the hunk at the cursor position, or all lines in the given range.",
		},
		s = { "<cmd>silent vertical Git<CR>", "Status" },
		S = { ":silent G switch ", "Switch", silent = false },
		t = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
	},
	w = {
		name = "Window",
		l = { "<c-w>l", "move the left window" },
		h = { "<c-w>h", "move the right window" },
		j = { "<c-w>j", "move the window below" },
		k = { "<c-w>k", "move the window above" },
		d = { "<cmd>windo diffthis<CR>", "show the difference between 2 windows" },
		D = { "<cmd>windo diffoff<CR>", "hide the difference between 2 windows" },
		s = { "<cmd>windo set scrollbind<CR>", "set scrollbind" },
		S = { "<cmd>windo set scrollbind!<CR>", "unset scrollbind" },
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })

wk.register({
	c = { "<cmd>silent CatppuccinCompile<CR>", "Recompile Catppuccin" },
	f = {
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format buffer",
	},
	w = {
		name = "VimWiki",
		l = { "<cmd>VimwikiTOC<CR>", "Create or update the Table of Contents for the current wiki file" },
	},
	h = { "<cmd>WhichKey<CR>", "Which Key" },
	s = { "<cmd>silent so %<CR>", "Source the file" },
	d = { "<cmd>silent Dashboard<CR>", "Dashboard" },
	t = { "<cmd>tabnew<CR>", "create an empty tab" },
	x = {
		"<cmd>silent !chmod u+x %<CR>",
		"make the file executable for the (u)ser , don't change (g)roup and (o)ther permissions",
	},
}, { prefix = "<leader>", noremap = true, silent = true, nowait = true })
-- }}}

-- Insert mode {{{
wk.register({
	["<c-_>"] = {
		function()
			comment_api.toggle.linewise.current()
		end,
		"comment/uncomment the line",
	},
	["<c-s>"] = { "<ESC><ESC><cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<c-k>"] = { "<c-o>C", "Delete to the end of the line" },
	-- ["<C-r>"] = { "<cmd>Telescope registers<CR>", "show registers" },
}, { prefix = "", mode = "i", noremap = true, silent = true, nowait = true })
-- }}}

-- Visual mode {{{
wk.register({
	-- ["."] = { ":normal.<CR>", "Repeat previous action" },
	-- ["p"] = { '"_dP', "Paste over currently selected text without yanking it" }, -- this causes pasting in select mode (when using snippets)
	["<"] = { "<gv", "Indent left" },
	[">"] = { ">gv", "Indent right" },
	["<c-_>"] = {
		function()
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			comment_api.toggle.linewise(vim.fn.visualmode())
		end,
		"comment/uncomment selected lines",
	},
	-- ["<c-k>"] = { ":m '<-2<CR>gv=gv", "Move up" },
	-- ["<c-j>"] = { ":m '>+1<CR>gv=gv", "Move down" },
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
}, { prefix = "", mode = "v", noremap = true, silent = true, nowait = true })

wk.register({
	-- s = {
	-- 	name = "search and replace",
	-- 	w = {
	-- 		'<esc><cmd>silent lua require("spectre").open_visual()<CR>',
	-- 		"Search current word",
	-- 	},
	-- },
}, { prefix = "<space>", mode = "v", noremap = true, silent = true, nowait = true })
-- }}}

-- Select mode {{{
wk.register({
	["<M-d>"] = { "<ESC>dei", "Delete the next word" },
	["<M-b>"] = { "<ESC>bi", "Move back" },
	["<M-f>"] = { "<ESC>ei", "Move forward" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<c-a>"] = { "<ESC>I", "Go to the beginning of line" },
	["<c-e>"] = { "<ESC>A", "Go to the end of line" },
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
}, { prefix = "", mode = "s", noremap = true, silent = true, nowait = true })
-- }}}

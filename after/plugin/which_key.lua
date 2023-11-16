local present, wk = pcall(require, "which-key")

if not present then
	return
end

local catppuccin = require("catppuccin")
local lualine = require("lualine")
local nvim_window = require("nvim-window")
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

function sync_bg_lualine_tmux()
	local current_background = get_highlight("Normal")["guibg"]
	-- vim.api.nvim_set_hl(0, "lualine_c", { bg = current_background == nil and "NONE" or "bg" })
	vim.api.nvim_set_hl(0, "StatusLine", { bg = current_background == nil and "NONE" or "bg" })
	set_tmux_status_color(current_background == nil and "default" or current_background)
	vim.wo.fillchars = "eob: "
	vim.cmd.highlight("NonText guifg=bg")
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
	["<A-l>"] = { "<CMD>silent NavigatorRight<CR>", "Go to the right window" },
	["<A-h>"] = { "<CMD>silent NavigatorLeft<CR>", "Go to the left window" },
	["<A-k>"] = { "<CMD>silent NavigatorUp<CR>", "Go to the up window" },
	["<A-j>"] = { "<CMD>silent NavigatorDown<CR>", "Go to the down window" },
	["<A-p>"] = { "<CMD>silent NavigatorPrevious<CR>", "Go to the down window" },
	["]<space>"] = { "o<ESC>k", "Insert a blank line below" },
	["[<space>"] = { "O<ESC>j", "Insert a blank line above" },
	["]g"] = { "<cmd>silent Gitsigns next_hunk<CR>", "Jump to the next hunk" },
	["[g"] = { ":Gitsigns prev_hunk<CR>", "Jump to the previous hunk" },
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
		a = {
			name = "appeareance",
			a = {
				function()
					local flavor = vim.o.background == "dark" and "catppuccin-mocha" or "catppuccin-latte"
					vim.cmd.colorscheme(vim.g.colors_name == "rose-pine" and flavor or "rose-pine")
				end,
				"alternative",
			},
			b = {
				function()
					if vim.o.background == "dark" then
						local rose_pine_options = require("rose-pine.config").options
						rose_pine_options.disable_background = false
						rose_pine_options.disable_float_background = false
						catppuccin.options.transparent_background = false
						catppuccin.compile()
					end
					vim.o.background = vim.o.background == "dark" and "light" or "dark"
					sync_bg_lualine_tmux()
				end,
				"Background color (Light/dark) ",
			},
			t = {
				function()
					local scheme = vim.g.colors_name
					if
						scheme ~= "catppuccin"
						and scheme ~= "catppuccin-mocha"
						and scheme ~= "catppuccin-latte"
						and scheme ~= "catppuccin-frappe"
						and scheme ~= "catppuccin-macchiato"
						and scheme ~= "rose-pine"
					then
						return
					end
					local next_transparency = not catppuccin.options.transparent_background
					if vim.o.background == "light" and next_transparency then
						return
					end
					local rose_pine_options = require("rose-pine.config").options
					rose_pine_options.disable_background = next_transparency
					rose_pine_options.disable_float_background = next_transparency
					catppuccin.options.transparent_background = next_transparency
					catppuccin.compile()
					-- vim.o.cursorline = not transparent
					-- vim.o.cursorlineopt = transparent and "number" or "number,line"
					vim.cmd.colorscheme(vim.g.colors_name)
					sync_bg_lualine_tmux()
				end,
				"Transparency",
			},
		},
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
		m = { "<cmd>make<CR>", "Make" },
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
		-- s = {
		-- 	[[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		-- 	"Change the word under the cursor in the line",
		-- 	silent = false,
		-- },
		-- S = {
		-- 	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		-- 	"Change the word under the cursor in the whole file",
		-- 	silent = false,
		-- },
		-- NOTE: the next two substitution commands depend on vim-abolish
		s = {
			[[:S/<c-r><c-w>/<c-r><c-w>/g<Left><left>]],
			"Change the word under the cursor in the line",
			silent = false,
		},
		S = {
			[[:%S/<c-r><c-w>/<c-r><c-w>/g<Left><left>]],
			"Change the word under the cursor in the whole file",
			silent = false,
		},
		t = {
			name = "tmux",
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
			t = { "<cmd>silent !tmux clock-mode<CR>", "Clock" },
			w = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux new-window -c " .. filepath)
				end,
				"Window",
			},
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
					vim.cmd("silent !tmux split-window -l 9 -c " .. filepath)
				end,
				"Horizontal split",
			},
			v = {
				function()
					local filepath = vim.fn.expand("%:p:h")
					vim.cmd("silent !tmux split-window -h -c " .. filepath)
				end,
				"Vertical split",
			},
			g = { "<cmd>silent !tmux new-window 'lazygit'<CR>", "LazyGit" },
		},
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		w = { nvim_window.pick, "Choose Win" },
		x = { vim.cmd.NvimTreeToggle, "Nvim Tree" },
		X = { "<cmd>silent call ToggleNetrw()<CR>", "Netrw" },
		z = { "<cmd>ZenMode<CR>", "Toggle Zen Mode" },
		-- Z = { "<c-w>|<c-w>_", "Maximize the window" },
		Z = { "<cmd>MaximizerToggle<cr>", "Maximize the window" },
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
		d = { "<cmd>silent Dashboard<CR>", "Dashboard" },
		f = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
		h = { "<cmd>WhichKey<CR>", "Which Key" },
		i = { "<cmd>silent LspInfo<CR>", "See LSP info" },
		L = { ":silent LspRestart ", "Restart a LSP", silent = false },
		l = { ":LspStop ", "Stop a LSP", silent = false },
		m = { "<cmd>messages<CR>", "messages" },
		q = { "<cmd>tabclose<CR>", "Close tab" },
		r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove a folder from workspace" },
		s = { "<cmd>silent so %<CR>", "Source the file" },
		t = { "<cmd>!task<CR>", "Show taskwarrior" },
		T = { "<cmd>tabnew<CR>", "Create an empty tab" },
		x = { "<cmd>BufferLinePickClose<CR>", "Pick a buffer to close" },
	},
	-- TODO: add the next keybinding if the bug is fixed
	-- ["z="] = { "<cmd>silent Telescope spell_suggest<CR>", "show spell suggestions" },
	-- ['"'] = { "<cmd>Telescope registers<CR>", "registers" },
	-- ["'"] = { "<cmd>Telescope marks<CR>", "marks" },
	-- ["q:"] = { "<cmd>Telescope command_history<CR>", "command history" },
	g = {
		-- d = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
		P = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek type definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition" },
		h = { "<cmd>Lspsaga finder def+ref+imp<CR>", "Show the definition, reference, implementation..." },
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		r = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
	},
	K = { "<cmd>Lspsaga hover_doc<CR>", "Hover info" },
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	name = "Groups",
	e = {
		name = "Emojis & Icons",
		e = { "<cmd>silent Telescope emoji<CR>", "Emojis" },
		i = { "<cmd>silent Telescope glyph<CR>", "Glyphs" },
	},
	m = {
		name = "Make",
		a = {
			":make all<CR>",
			"All",
		},
		B = {
			":make clean-build<CR>",
			"Clean build",
		},
		b = {
			":make build<CR>",
			"Build",
		},
		c = {
			":make clean<CR>",
			"Clean",
		},
		d = {
			":make docs<CR>",
			"Generate docs",
		},
		G = {
			":make clean && make generate && make build<CR>",
			"Clean, generate and build again",
		},
		g = {
			":make generate<CR>",
			"Generate",
		},
		h = {
			":make help<CR>",
			"Help",
		},
		i = {
			":make install<CR>",
			"Install",
		},
		m = {
			":make ",
			"Insert a make command",
			silent = false,
		},
		r = {
			":make run<CR>",
			"Run",
		},
		t = {
			":make test<CR>",
			"Test",
		},
		w = {
			":make watch<CR>",
			"Watch",
		},
	},
	s = {
		name = "Session",
		m = { "<cmd>Obsession<CR>", "Make a session" },
		d = { "<cmd>Obsession!<CR>", "Delete the session" },
	},
	d = {
		name = "Debugger",
		b = {
			vim.cmd.DapToggleBreakpoint,
			"Toggle breakpoint",
		},
		C = {
			dap.run_to_cursor,
			"Run to cursor",
		},
		c = {
			vim.cmd.DapContinue,
			"Continue",
		},
		d = {
			dap.down,
			"Go down in current stacktrace without stepping",
		},
		e = {
			function()
				dapui.eval(nil, { enter = true })
			end,
			"Evaluate expression",
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
		s = {
			vim.cmd.DapStepInto,
			"Step into",
		},
		N = {
			dap.step_back,
			"Step back",
		},
		n = {
			vim.cmd.DapStepOver,
			"Step over (next)",
		},
		f = {
			vim.cmd.DapStepOut,
			"Step out (finish)",
		},
		p = {
			dap.pause,
			"Pause the thread",
		},
		R = {
			dap.restart,
			"Restart the current session",
		},
		r = {
			vim.cmd.DapToggleRepl,
			"Toggle repl",
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
			"Go up in current stacktrace without stepping",
		},
		w = {
			function()
				dapui.elements.watches.add(nil)
			end,
			"Watch the word under cursor",
		},
	},
	t = {
		name = "Toggle",
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
		-- d = { "<cmd>silent Dashboard<CR>", "dashboard" },
		D = { "<cmd>silent DBUIToggle<CR>", "DB UI" },
		d = { ":silent lua ToggleDiagnostics()<CR>", "diagnostics" },
		e = { ":lua require('material.functions').toggle_eob()<CR>", "eob" },
		g = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "git line blame" },
		h = {
			"<cmd>TSToggle highlight<CR>",
			"Treesitter highlight",
		},
		L = { "<cmd>Lazy<CR>", "Lazy" },
		l = { "<cmd>Telescope ToggleLSP<CR>", "LSP" },
		m = { "<cmd>MaximizerToggle<CR>", "Maximize window" },
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
			name = "Terminal",
			h = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm direction=horizontal dir=" .. p
					vim.cmd(cmd)
				end,
				"Horizontal",
			},
			v = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm size=80 direction=vertical dir=" .. p
					vim.cmd(cmd)
				end,
				"Vertical",
			},
			f = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm size=160 direction=float dir=" .. p
					vim.cmd(cmd)
				end,
				"Float",
			},
			t = {
				function()
					local p = vim.fn.expand("%:p:h")
					local cmd = "ToggleTerm direction=tab dir=" .. p
					vim.cmd(cmd)
				end,
				"Tab",
			},
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
		o = { "<cmd>silent !open https://calendar.google.com/calendar/u/0/r<CR>", "Open Google Calendar" },
		g = { ":Calendar ", "Go to date (mm dd yyyy)", silent = false },
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
		A = {
			"<cmd>silent vertical G commit --amend<CR>",
			"Amend commit with staged changes",
		},
		B = { "<cmd>Gitsigns blame_line<CR>", "Blame on the current line" },
		b = { "<cmd>silent G blame<CR>", "Blame on the current file" },
		C = { ":silent G checkout ", "Checkout", silent = false },
		c = { "<cmd>silent vertical G commit<CR>", "Commit" },
		D = { "<cmd>silent Gvdiffsplit! HEAD~<CR>", "Diff with previous commit" },
		d = { "<cmd>silent Gvdiffsplit!<CR>", "Diff" },
		f = { "<cmd>silent G fetch<CR>", "Fetch" },
		g = { ":Ggrep! -q ", "Grep", silent = false },
		h = { get_git_hash, "copy current git hash to g register" },
		L = { "<cmd>silent G log --stat<CR>", "Log with stats" },
		l = { "<cmd>silent G log --decorate<CR>", "Log" },
		n = { "<cmd>silent G! difftool --name-only HEAD~1 | cfirst <CR>", "changed files since last commit" },
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
		W = { "<cmd>silent G restore --staged %<CR>", "Unstage the file" },
		w = { "<cmd>silent G add %<CR>", "Stage the file" },
	},
	w = {
		name = "Window",
		d = { "<cmd>windo diffthis<CR>", "Show the difference between 2 windows" },
		D = { "<cmd>windo diffoff<CR>", "Hide the difference between 2 windows" },
		h = { "<c-w>h", "Move the right window" },
		j = { "<c-w>j", "Move the window below" },
		k = { "<c-w>k", "Move the window above" },
		l = { "<c-w>l", "Move the left window" },
		m = { "<cmd>MaximizerToggle<CR>", "Maximize the window" },
		o = { "<cmd>only<CR>", "close all other windows" },
		p = { nvim_window.pick, "Pick a window" },
		s = { "<cmd>windo set scrollbind<CR>", "Set scrollbind" },
		S = { "<cmd>windo set scrollbind!<CR>", "Unset scrollbind" },
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
	x = {
		"<cmd>silent !chmod u+x %<CR>",
		"Make the file executable for the (u)ser , don't change (g)roup and (o)ther permissions",
	},
}, { prefix = "<leader>", noremap = true, silent = true, nowait = true })
-- }}}

-- Insert mode {{{
wk.register({
	["<c-_>"] = {
		function()
			comment_api.toggle.linewise.current()
		end,
		"Comment/uncomment the line",
	},
	["<c-s>"] = { "<ESC><ESC><cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<c-k>"] = { "<c-o>C", "Delete to the end of the line" },
	-- ["<C-r>"] = { "<cmd>Telescope registers<CR>", "show registers" },
}, { prefix = "", mode = "i", noremap = true, silent = true, nowait = true })
-- }}}

-- Visual mode {{{
wk.register({
	[";"] = {
		name = "Quick",
		S = { 'y:%S/<c-r>"/<c-r>"/g<LEFT><LEFT>', "Change the selection in whole document", silent = false },
		s = { 'y:S/<c-r>"/<c-r>"/g<LEFT><LEFT>', "Change the selection in this line", silent = false },
	},
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
		"Comment/uncomment selected lines",
	},
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
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
	["<c-a>"] = { "<ESC>I", "Go to the beginning of line" },
	["<c-e>"] = { "<ESC>A", "Go to the end of line" },
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
}, { prefix = "", mode = "s", noremap = true, silent = true, nowait = true })
-- }}}

-- terminal mode {{{
wk.register({
	["<A-l>"] = { "<CMD>silent NavigatorRight<CR>", "Go to the right window" },
	["<A-h>"] = { "<CMD>silent NavigatorLeft<CR>", "Go to the left window" },
	["<A-k>"] = { "<CMD>silent NavigatorUp<CR>", "Go to the up window" },
	["<A-j>"] = { "<CMD>silent NavigatorDown<CR>", "Go to the down window" },
	["<A-p>"] = { "<CMD>silent NavigatorPrevious<CR>", "Go to the down window" },
}, { prefix = "", mode = "t", noremap = true, silent = true, nowait = true })
-- }}}

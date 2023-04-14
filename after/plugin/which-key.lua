local present, wk = pcall(require, "which-key")

if not present then
	return
end

local catppuccin = require("catppuccin")
local lualine = require("lualine")
local utils = require("utils")

local opts = { noremap = true, silent = true }

local options = {
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 0, 0 },
		winblend = 0,
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
}

wk.setup(options)

-- old MAPPINGS {{{
-- ---------------------------------------------------------------------
-- run prettier in the current directory
-- vim.key hap.set('n', '<leader>P',
--   ':silent !cd ' .. utils.get_top_level() ..
--   '&& prettier --ignore-path .gitignore -w .<CR>', opts)
-- vim.keymap.set('n', '<leader>p', ':silent !prettier --ignore-path .gitignore -w %<CR>',
--   opts)

-- close and open the file again
-- vim.keymap.set('n', '<leader>r', ':bd<CR><c-o>', opts)

-- search the visually selected text, not required in nvim>0.8
-- cmd([[
-- vnoremap <silent> * :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy/<C-R><C-R>=substitute(
--   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
-- vnoremap <silent> # :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy?<C-R><C-R>=substitute(
--   \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
-- ]])
-- }}}

-- Normal mode {{{
wk.register({
	["]<space>"] = { "o<ESC>k", "Insert a blank line below" },
	["[<space>"] = { "O<ESC>j", "Insert a blank line above" },
	["[b"] = { "<cmd>bprev<CR>", "Go to previous buffer" },
	["]b"] = { "<cmd>bnext<CR>", "Go to next buffer" },
	["]B"] = { "<cmd>BufferLineMoveNext<CR>", "Move the buffer to the next position" },
	["[B"] = { "<cmd>BufferLineMovePrev<CR>", "Move the buffer to the previous position" },
	["]c"] = { "<cmd>silent Gitsigns next_hunk<CR>", "Jump to the next hunk" },
	["[c"] = { ":Gitsigns prev_hunk<CR>", "Jump to the previous hunk" },
	["[l"] = { "<cmd>silent lprev<CR>", "See the previous item in local list" },
	["]l"] = { "<cmd>silent lnext<CR>", "See the next item in local list" },
	["[L"] = { "<cmd>silent lfirst<CR>", "See the first item in local list" },
	["]L"] = { "<cmd>silent llast<CR>", "See the last item in local list" },
	["[p"] = { "<cmd>pu!<CR>", "Paste above current line" },
	["]p"] = { "<cmd>pu<CR>", "Paste below current line" },
	["]t"] = {
		require("todo-comments").jump_next,
		"Next todo comment",
	},
	["[t"] = {
		require("todo-comments").jump_prev,
		"Previous todo comment",
	},
	["[q"] = { "<cmd>silent cprev<CR>", "Show the previous item in QuickFix" },
	["]q"] = { "<cmd>silent cnext<CR>", "Show the next item in QuickFix" },
	["[Q"] = { "<cmd>silent cfirst<CR>", "See the first item in QuickFix" },
	["]Q"] = { "<cmd>silent clast<CR>", "See the last item in QuickFix" },
	["]x"] = { "<cmd>BufferLineCloseRight<CR>", "Close all the buffers to the right" },
	["[x"] = { "<cmd>BufferLineCloseLeft<CR>", "Close all the buffers to the left" },
	["<c-_>"] = { ":Commentary<CR>", "Toggle comment in this line" },
	["<C-Left>"] = { ":vertical resize +2<CR>", "Increase window width" },
	["<C-Right>"] = { ":vertical resize -1<CR>", "Decrease window width" },
	["<C-Up>"] = { ":resize -1<CR>", "Increase window height" },
	["<C-Down>"] = { ":resize +1<CR>", "Decrease window height" },
	["<c-s>"] = { "<cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<cmd>wall<CR>", "Save all buffers" },
	[";"] = {
		name = "Quick",
		["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "Go to 1st buffer" },
		["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Go to 2nd buffer" },
		["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Go to 3rd buffer" },
		["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Go to 4th buffer" },
		["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Go to 5th buffer" },
		["6"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Go to 6th buffer" },
		["7"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Go to 7th buffer" },
		["8"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Go to 8th buffer" },
		["9"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Go to 9th buffer" },
		z = { "<cmd>ZenMode<CR><cmd>redraw<CR>", "Toggle Zen Mode" },
		Z = { "<c-w>|<c-w>_", "Maximize the window" },
		e = { "<cmd>silent Telescope diagnostics cwd=" .. utils.get_top_level() .. "<CR>", "List diagnostics" },
		E = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
		o = { "<cmd>silent !xdg-open %<CR>", "Open the current file" },
		O = { "<cmd>silent !xdg-open .<CR>", "Open the current directory" },
		[";"] = { ":bd<CR>", "Delete current buffer" },
		q = { "<c-w>q", "Quit current window" },
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
		f = { "<cmd>Telescope find_files cwd=" .. utils.get_top_level() .. "<CR>", "Find files" },
		-- f = {
		-- 	function()
		-- 		require("telescope.builtin").find_files({ hidden = true, cwd = utils.get_top_level(), no_ignore = true })
		-- 	end,
		-- 	"Find files",
		-- },
		F = { "<cmd>Telescope git_files <CR>", "Fuzzy search for files tracked by Git" },
		g = { "<cmd>Telescope live_grep  cwd=" .. utils.get_top_level() .. "<CR>", "Live grep" },
		G = { "<cmd>Telescope grep_string cwd=" .. utils.get_top_level() .. "<CR>", "Grep string under the cursor" },
		b = { "<cmd>Telescope buffers<CR>", "List open buffers" },
		C = {
			function()
				require("telescope.builtin").colorscheme()
			end,
			"List open buffers",
		},
		d = { "<cmd>Telescope file_browser<CR>", "File/Folder browser" },
		D = { "<cmd>Telescope file_browser cwd=" .. utils.get_top_level() .. "<CR>", "File/Folder browser from root" },
		j = { "<cmd>silent Telescope emoji<CR>", "Emoji" },
		J = { "<cmd>silent Telescope glyph<CR>", "Glyph" },
		n = { "<cmd>silent Explore<CR>", "File Explorer" },
		T = { "<cmd>TodoTelescope cwd=" .. utils.get_top_level() .. "<CR>", "Show Todos for current project" },
		r = { "<cmd>Telescope oldfiles<CR>", "Show recently opened files" },
		h = { "<cmd>Telescope help_tags<CR>", "Show help tags" },
		H = { "<cmd>Telescope man_pages<CR>", "Show help tags" },
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		w = { "<cmd>HopWordMW<CR>", "Hop to a word" },
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
		i = { "<cmd>silent LspInfo<CR>", "See LSP info" },
		a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add a folder to workspace" },
		r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove a folder from workspace" },
		f = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
		C = {
			name = "Color Picker",
			h = { "<cmd>silent VCoolor<CR>", "HEX color <M-c>" }, -- <M-c>
			H = { "<cmd>silent VCoolIns h<CR>", "HSL color <M-v>" }, -- <M-v>
			r = { "<cmd>silent VCoolIns r <CR>", "RGB color <M-r>" }, -- <M-r>
			-- R = { "<cmd>silent bufdo bd<CR>", "Insert a RGBA color" }, -- <M-w>
		},
	},
	["z="] = { "<cmd>silent Telescope spell_suggest<CR>", "show spell suggestions" },
	f = { "<cmd>HopChar1CurrentLine<CR>", "Hop to a character in current line" },
	F = { "<cmd>HopWordCurrentLine<CR>", "Hop to a word in current line" },
	-- n = { "nzt", "show next search result" },
	-- N = { "Nzt", "show previous search result" },
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	name = "Groups",
	s = {
		name = "Session",
		m = { "<cmd>Obsession " .. utils.get_top_level() .. "<CR>", "Make a session" },
		d = { "<cmd>Obsession!<CR>", "Delete the session" },
	},
	t = {
		name = "Toggle",
		t = {
			function()
				catppuccin.options.transparent_background = not catppuccin.options.transparent_background
				catppuccin.compile()
				vim.cmd.colorscheme(vim.g.colors_name)
			end,
			"transparency",
		},
		T = {
			name = "treesitter",
			h = { "<cmd>TSToggle highlight<CR>", "highlight" },
			r = { "<cmd>TSToggle rainbow<CR>", "rainbow" },
			i = { "<cmd>TSToggle indent<CR>", "indent" },
		},
		b = {
			function()
				vim.o.background = vim.o.background == "dark" and "light" or "dark"
				catppuccin.options.transparent_background = not catppuccin.options.transparent_background
				vim.cmd.colorscheme(vim.g.colors_name)
				catppuccin.compile()
			end,
			"light/dark background",
		},
		B = {
			function()
				vim.o.background = vim.o.background == "dark" and "light" or "dark"
			end,
			"background color",
		},
		d = { "<cmd>silent Dashboard<CR>", "dashboard" },
		g = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "git line blame" },
		l = { "<cmd>Telescope ToggleLSP<CR>", "LSP" },
		h = {
			function()
				vim.o.cmdheight = vim.o.cmdheight == 0 and 1 or 0
			end,
			"cmdheight 0 or 1",
		},
		r = {
			"<cmd>TSDisable rainbow<bar>TSEnable rainbow<CR>",
			"rainbow",
		},
		z = {
			"<cmd>ZenMode<CR>",
			"zen mode",
		},
		p = {
			"<cmd>BufferLineTogglePin<CR>",
			"pin buffer",
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
	},
	b = {
		name = "buffer",
		o = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "close other buffers" },
		a = { "<cmd>bufdo bd<CR>", "close all buffers" },
	},
	C = {
		name = "Comment",
		t = { "ITODO: <ESC><cmd>silent Commentary<CR>f:a ", "TODO comment this line" },
		T = { "OTODO: <ESC><cmd>silent Commentary<CR>f:a ", "TODO comment above this line" },
		e = { "ITEST: <ESC><cmd>silent Commentary<CR>f:a ", "TEST comment this line" },
		E = { "OTEST: <ESC><cmd>silent Commentary<CR>f:a ", "TEST comment above this line" },
		N = { "ONOTE: <ESC><cmd>silent Commentary<CR>f:a ", "NOTE comment above this line" },
		n = { "INOTE: <ESC><cmd>silent Commentary<CR>^", "NOTE comment this line" },
		F = { "OFIX: <ESC><cmd>silent Commentary<CR>f:a ", "FIX comment above this line" },
		f = { "IFIX: <ESC><cmd>silent Commentary<CR>^", "FIX comment this line" },
		W = { "OWARNING: <ESC><cmd>silent Commentary<CR>f:a ", "WARNING comment above this line" },
		w = { "IWARNING: <ESC><cmd>silent Commentary<CR>^", "WARNING comment this line" },
		H = { "OHACK: <ESC><cmd>silent Commentary<CR>f:a ", "HACK comment above this line" },
		h = { "IHACK: <ESC><cmd>silent Commentary<CR>^", "HACK comment this line" },
		P = { "OPERF: <ESC><cmd>silent Commentary<CR>f:a ", "PERF comment above this line" },
		p = { "IPERF: <ESC><cmd>silent Commentary<CR>^", "PERF comment this line" },
		l = { "<cmd>silent  TodoLocList<CR>", "List all local comments" },
		q = { "<cmd>silent TodoQuickFix<CR>", "List all comments as Quickfix" },
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
		s = { "<cmd>silent vertical Git<CR>", "Status" },
		S = { ":silent G switch ", "Switch", silent = false },
		f = { "<cmd>silent G fetch<CR>", "Fetch" },
		P = { "<cmd>silent G push<CR>", "Push" },
		p = { "<cmd>silent G pull<CR>", "Pull" },
		l = { "<cmd>silent vertical G log --decorate<CR>", "Log" },
		L = { "<cmd>silent vertical G log --decorate -p<CR>", "Log with differences" },
		n = { "<cmd>silent vertical G log --stat<CR>", "Log with stats" },
		c = { "<cmd>silent vertical G commit<CR>", "Commit" },
		C = { ":silent G checkout ", "Checkout", silent = false },
		["["] = { "<cmd>silent G checkout HEAD^<CR>", "Checkout previous commit" },
		["]"] = {
			"<cmd>silent !git checkout $(git rev-list --topo-order HEAD..$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') | tail -1)<CR>",
			"Checkout next commit",
		},
		a = {
			"<cmd>silent vertical G commit --amend<CR>",
			"Amend commit with staged changes",
		},
		d = { "<cmd>silent Gvdiffsplit<CR>", "Diff" },
		D = { "<cmd>silent Gvdiffsplit HEAD~<CR>", "Diff with previous commit" },
		b = { "<cmd>silent G blame<CR>", "Blame on the current file" },
		B = { "<cmd>Gitsigns blame_line<CR>", "Blame on the current line" },
		o = { "<cmd>silent GBrowse<CR>", "Open in the browser" },
		r = {
			"<cmd>Gitsigns reset_hunk<CR>",
			"Reset the lines of the hunk at the cursor position, or all lines in the given range.",
		},
		R = { "<cmd>Gitsigns toggle_deleted<CR>", "Toggle deleted lines" },
		v = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
		V = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
	},
	h = {
		name = "hop",
		-- a = { "<cmd>HopAnywhereMW<CR>", "Hop Anywhere" },
		l = { "<cmd>HopLineMW<CR>", "Hop to a line" },
		s = { "<cmd>HopLineStartMW<CR>", "Hop to a line start" },
		w = { "<cmd>HopWordMW<CR>", "Hop to a word" },
		c = { "<cmd>HopChar1MW<CR>", "Hop to a character" },
		p = { "<cmd>HopPatternMW<CR>", "Hop to a pattern" },
	},
	w = {
		name = "Window",
		l = { "<c-w>l", "move the left window" },
		h = { "<c-w>h", "move the right window" },
		j = { "<c-w>j", "move the window below" },
		k = { "<c-w>k", "move the window above" },
		d = { "<cmd>windo diffthis<CR>", "show the difference between 2 windows" },
		D = { "<cmd>windo diffoff<CR>", "hide the difference between 2 windows" },
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
	x = {
		"<cmd>silent !chmod u+x %<CR",
		"make the file executable for the (u)ser , don't change (g)roup and (o)ther permissions",
	},
}, { prefix = "<leader>", noremap = true, silent = true, nowait = true })
-- }}}

-- Insert mode {{{
wk.register({
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
	["<c-k>"] = { "<c-o>C", "Delete to the end of the line" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	-- ["<C-x>"] = { "<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
	["<c-_>"] = { "<ESC>:Commentary<CR>", "Comment out visually selected lines" },
}, { prefix = "", mode = "i", noremap = true, silent = true, nowait = true })
-- }}}

-- Visual mode {{{
wk.register({
	["."] = { ":normal.<CR>", "Repeat previous action" },
	["p"] = { '"_dP', "Paste over currently selected text without yanking it" },
	["<"] = { "<gv", "Indent left" },
	[">"] = { ">gv", "Indent right" },
	["<c-k>"] = { ":m '<-2<CR>gv=gv", "Move up" },
	["<c-j>"] = { ":m '>+1<CR>gv=gv", "Move down" },
	["<c-s>"] = { "<ESC><cmd>silent update<CR>", "Save buffer" },
	["<M-s>"] = { "<ESC><cmd>wall<CR>", "Save all buffers" },
	["<c-_>"] = { ":Commentary<CR>", "Toggle comment in this line" },
}, { prefix = "", mode = "v", noremap = true, silent = true, nowait = true })
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
}, { prefix = "", mode = "v", noremap = true, silent = true, nowait = true })
-- }}}

local present, wk = pcall(require, "which-key")

if not present then
	return
end

local catppuccin = require("catppuccin")
local lualine = require("lualine")
local utils = require("utils")

local options = {
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		winblend = 0,
		margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	layout = {
		spacing = 6, -- spacing between columns
	},
	-- triggers = "auto", -- automatically setup triggers
}

wk.setup(options)

vim.keymap.set("n", "<leader>h", "<cmd>WhichKey<CR>", { noremap = true, silent = true })

wk.register({
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
		t = { "<cmd>TodoTelescope cwd=" .. utils.get_top_level() .. "<CR>", "Show Todos for current project" },
		r = { "<cmd>Telescope oldfiles<CR>", "Show recently opened files" },
		h = { "<cmd>Telescope help_tags<CR>", "Show help tags" },
		H = { "<cmd>Telescope man_pages<CR>", "Show help tags" },
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
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
		[","] = { "<cmd>HopLineMW<CR>", "Hop to a line" },
		w = { "<cmd>HopWordMW<CR>", "Hop to a word" },
		c = { "<cmd>HopChar1MW<CR>", "Hop to a character" },
		p = { "<cmd>HopPatternMW<CR>", "Hop to a pattern" },
		j = { "<c-w>j", "go N windows down" },
		k = { "<c-w>k", "go N windows up" },
		h = { "<c-w>h", "go N windows right" },
		l = { "<c-w>l", "go N windows left" },
		e = { "<cmd>silent NvimTreeToggle<CR>", "Toggle NvimTree" },
		E = { "<cmd>silent Ex<CR>", "Explore directory of current file" },
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
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
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
		b = {
			function()
				catppuccin.options.transparent_background = not catppuccin.options.transparent_background
				vim.o.background = vim.o.background == "dark" and "light" or "dark"
				catppuccin.compile()
				vim.cmd.colorscheme(vim.g.colors_name)
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
		o = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "close other buffers, put the cursor back" },
		a = { "<cmd>bufdo bd<CR>", "close all buffers" },
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })

wk.register({
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
}, { prefix = "<leader>", noremap = true, silent = true, nowait = true })

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

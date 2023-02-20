local present, wk = pcall(require, "which-key")

if not present then
	return
end

local catppuccin = require("catppuccin")
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

vim.keymap.set("n", "<M-h>", "<cmd>WhichKey<CR>", { noremap = true, silent = true })

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
		d = { "<cmd>Telescope file_browser cwd=" .. utils.get_top_level() .. "<CR>", "File/Folder browser" },
		j = { "<cmd>silent Telescope emoji<CR>", "Emoji" },
		t = { "<cmd>TodoTelescope cwd=" .. utils.get_top_level() .. "<CR>", "Show Todos for current project" },
		r = { "<cmd>Telescope oldfiles<CR>", "Show recently opened files" },
		h = { "<cmd>Telescope help_tags<CR>", "Show help tags" },
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		["<space>"] = { "<cmd>Telescope<CR>", "Telescope builtins" },
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
	},
	b = {
		name = "buffer",
		o = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "close other buffers, put the cursor back" },
		a = { "<cmd>bufdo bd<CR>", "close all buffers" },
	},
	j = { "<c-w>j", "go N windows down" },
	k = { "<c-w>k", "go N windows up" },
	h = { "<c-w>h", "go N windows right" },
	l = { "<c-w>l", "go N windows left" },
	e = { "<cmd>silent NvimTreeToggle<CR>", "Toggle NvimTree" },
	E = { "<cmd>silent Ex<CR>", "Explore directory of current file" },
	["1"] = { "1<c-w>w", "Go to 1st window" },
	["2"] = { "2<c-w>w", "Go to 2nd window" },
	["3"] = { "3<c-w>w", "Go to 3rd window" },
	["4"] = { "4<c-w>w", "Go to 4th window" },
	["5"] = { "5<c-w>w", "Go to 5th window" },
	["6"] = { "6<c-w>w", "Go to 6th window" },
	["7"] = { "7<c-w>w", "Go to 7th window" },
	["8"] = { "8<c-w>w", "Go to 8th window" },
	["9"] = { "9<c-w>w", "Go to 9th window" },
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })

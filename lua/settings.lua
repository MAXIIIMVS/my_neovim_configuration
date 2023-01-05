local home = os.getenv("HOME")
local utils = require("utils")
local g = vim.g
local o = vim.o
local w = vim.wo
local b = vim.bo
local cmd = vim.cmd

-- Fundamental {{{
g.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal" -- removed blank
w.number = true
w.relativenumber = true
w.signcolumn = "yes:1"
o.fileencodings = "utf-8,sjis,euc-jp,latin"
o.encoding = "utf-8"
o.title = true
o.autoindent = true
o.backup = false
o.hlsearch = true
o.incsearch = true
o.smartcase = true
o.showcmd = true
o.cmdheight = 0
o.laststatus = 3
o.scrolloff = 2
o.timeoutlen = 400
-- incremental substitution (neovim)
if vim.fn.has("nvim") == 1 then
	o.inccommand = "split"
end

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
-- xterm-bracketed-paste
-- set t_BE= -- NOTE: I don't know how to set this
o.ruler = false
o.showmatch = false
o.lazyredraw = false
o.ignorecase = true -- NOTE: I'm not sure about this or smartcase
o.backspace = "start,eol,indent"
o.path = o.path .. "**" -- or w.path, IDK
o.wildignore = o.wildignore .. "*/node_modules/*"

-- Turn off paste mode when leaving insert
cmd("autocmd InsertLeave * set nopaste")

-- Add asterisks in block comments
b.formatoptions = b.formatoptions .. "r"
--}}}

-- Syntax theme "{{{
-----------------------------------------------------------------------
-- true color
if vim.fn.exists("&termguicolors") == 1 and vim.fn.exists("&winblend") then
	cmd("syntax enable")
	o.termguicolors = true
	o.wildoptions = "pum"
	w.winblend = 0
	o.pumblend = 5
	o.background = "dark"
	-- Use NeoSolarized
	-- vim.g.neosolarized_termtrans = 1
	-- require('colors')
	-- cmd('colorscheme NeoSolarized')
end
-- }}}

-- Settings {{{
-- ---------------------------------------------------------------------
-- o.omnifunc = 'syntaxcomplete#Complete'
o.errorbells = false
o.belloff = "all"
o.confirm = true
-- o.guifont= 'firaCode'
o.guifont = "FiraMono Nerd Font Medium"
vim.go.t_Co = "256"
-- vim.go.t_ut = ""
o.clipboard = "unnamedplus"
o.mouse = "a"
o.autoread = true
b.swapfile = false
o.showmode = true
b.textwidth = 80
w.linebreak = true
o.autochdir = true -- NOTE: When this option is on, some plugins may not work.
o.hidden = true
w.colorcolumn = "80"
-- cmd('highlight ColorColumn ctermbg=DarkBlue')
o.wildmode = "full"
o.wildmenu = true
g.wildmenu = true
-- o.statusline = '%F'
o.updatetime = 500
w.foldenable = true
-- NOTE: foldlevelstart: -1: default, 0: all folds closed, 1: some folds
-- closed, 99: no folds closed
o.foldlevelstart = 99
-- w.foldnestmax = 10
w.foldmethod = "indent" -- manual, indent, syntax, marker, expr, diff
w.conceallevel = 0
-- python3 path: chage if it's necessary, -- NOTE: I'm not sure about this
g.python3_host_prog = "/usr/bin/python3"
-- cmd('autocmd FileType javascript set filetype=javascriptreact')
-- cmd('autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact')
-- cmd('autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact')
cmd([[
au FocusGained,BufEnter * :silent! !
hi CursorLine cterm=NONE ctermbg=232
autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None
autocmd InsertLeave * highlight  CursorLine ctermbg=232
]])

-- o.smarttab = true
-- b.smartindent = true
o.tabstop = 2
b.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
b.shiftwidth = 2
o.autoindent = true
b.autoindent = true
o.expandtab = true
b.expandtab = true
-- o.nrformats = "alpha,bin,hex"

-- vim.cmd[[colorscheme aurora]]
-- hide tildes (only vim), this doesn't work for nvim-tree
w.fillchars = "eob: "
-- or put this after colorscheme (vim & nvim), works for nvim-tree
vim.cmd("hi NonText guifg=bg")
-- }}}

-- Highlights {{{
-----------------------------------------------------------------------
w.cursorline = true

cmd([[
if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
]])

utils.create_augroup({
	{ "WinEnter", "*", "set", "cul" },
	{ "WinLeave", "*", "set", "nocul" },
}, "BgHighlight")

-- change the split bar color to yellow
cmd("highlight VertSplit guifg=#32afff")
-- }}}

-- format files when using :wq and not using sync in lsp formatting
-- vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- dashboard {{{
vim.g.dashboard_default_executive = "telescope"

local db = require("dashboard")
-- macos
-- db.preview_command = "cat | lolcat -F 0.3"
-- linux
-- db.preview_command = "ueberzug"
--

-- source: https://emojicombos.com/
db.custom_header = {
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⠋⣿⡟⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⠃⠀⣿⡇⠈⢿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡿⠁⠀⠀⣿⡇⠀⠈⢿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡿⠁⠀⠀⠀⣿⡇⠀⠀⠀⢻⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡟⠁⢀⣀⣤⣤⣿⣧⣤⣄⡀⠀⢻⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣴⣿⣿⠿⠛⠛⣿⡟⠛⠿⣿⣿⣦⣽⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⠟⠋⠀⠀⠀⠀⣿⡇⠀⠀⠀⠉⠻⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠈⢿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⢻⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⣿⡟⢿⣷⡀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⢀⣾⡿⠃⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠈⢿⣿⡄⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⢠⣾⡿⠁⠀⠘⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⣼⣿⠇⠀⠈⢻⣿⡄⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⣠⣿⡟⠁⠀⠀⠀⢹⣿⣧⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⣸⣿⡟⠀⠀⠀⠀⢻⣿⣆⠀⠀⠀⠀]],
	[[⠀⠀⠀⣰⣿⡟⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⣠⣾⣿⠟⠀⠀⠀⠀⠀⠀⠻⣿⣆⠀⠀⠀]],
	[[⠀⠀⣰⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣷⣦⣄⣀⣀⣿⣇⣀⣠⣴⣾⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣦⠀⠀]],
	[[⠀⣴⣿⣯⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣽⣿⣧⠀]],
	[[⠘⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠓]],
	[[                                           ]],
	[[            FOR THE GREATER GOOD           ]],
}

-- db.custom_header = {
-- 	[[⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣶⣿⣿⣿⣷⣶⣶⣶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀]],
-- 	[[⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀]],
-- 	[[⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀]],
-- 	[[⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇]],
-- 	[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
-- 	[[⣿⣿⡏⠉⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠉⠉⣿⣿]],
-- 	[[⢻⣿⡇⠀⠀⠀⠈⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⢀⣿⡇]],
-- 	[[⠘⣿⣷⡀⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣿⣿⠿⠛⠋⠀⠀⠀⠀⠀⠀⢀⣼⣿⠃]],
-- 	[[⠀⠹⣿⣿⣶⣦⣤⣀⣀⣀⣀⣀⣤⣶⠟⡿⣷⣦⣄⣀⣀⣀⣠⣤⣤⣶⣿⣿⡟⠀]],
-- 	[[⠀⠀⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⡇⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀]],
-- 	[[⠀⢈⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⣷⠀⣼⣷⠀⣸⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⡇⠀]],
-- 	[[⠀⠘⣿⣿⣿⡟⠋⠀⠀⠰⣿⣿⣿⣷⣿⣿⣷⣿⣿⣿⣿⡇⠀⠀⠀⣿⣿⠟⠁⠀]],
-- 	[[⠀⠀⠈⠉⠀⠈⠁⠀⠀⠘⣿⣿⢿⣿⣿⢻⣿⡏⣻⣿⣿⠃⠀⠀⠀⠈⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⣿⣿⢸⣿⡇⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⣿⣿⢸⣿⡇⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⣿⣿⢸⣿⡇⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⣿⣿⢸⣿⠃⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡇⣿⣿⢸⣿⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠇⢿⡿⢸⡿⠀⠿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 	[[                              ]],
-- 	[[     WE ARE NOT YOUR KIND     ]],
-- }

db.custom_center = {
	{
		icon = "  ",
		desc = "Recently latest session                 ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "File Browser                            ",
		action = "Telescope file_browser cwd=" .. home,
		shortcut = "SPC f b",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		action = "Telescope live_grep",
		shortcut = "SPC f w",
	},
	{
		icon = "  ",
		desc = "Open Help Tags                          ",
		action = "Telescope help_tags",
		shortcut = "SPC f d",
	},
}
db.custom_footer = { "👑 Mustafa Hayati 👑" }
db.hide_statusline = true
db.hide_tabline = true
db.hide_winbar = true
db.preview_file_height = 11
db.preview_file_width = 70
-- }}}

-- emoji shortcuts {{{
-- ---------------------------------------------------------------------
cmd([[
ab :check: ✅
ab :empty: 🔳
ab :check_mark: ✔
ab :pi: 𝞹
ab :cross: ❌
ab :pin: 📌
ab :right: ➡
ab :left: ⬅
ab :up: ⬆
ab :down: ⬇
ab :point_right: 👉
ab :point_left: 👈
ab :point_up: 👆
ab :point_down: 👇
ab :bulb: 💡
ab :bomb: 💣
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :telephone: 📞
ab :email: 📧
ab :laptop: 💻
ab :desktop: 🖥
ab :rocket: 🚀
ab :ninja: 🥷
ab :palette: 🎨
ab :low_brightness: 🔅
ab :high_brightness: 🔆
ab :crown: 👑
ab :trident: 🔱
ab :robot: 🤖
ab :poop: 💩
ab :ghost: 👻
ab :wine_glass: 🍷
ab :mobile_phone: 📱
ab :red_heart: ❤️
ab :skull: 💀
ab :fox: 🦊
ab :bird: 🐦
ab :crab: 🦀
ab :butterfly: 🦋
ab :hedgehog: 🦔
ab :snake: 🐍
ab :octopus: 🐙
ab :duck: 🦆
ab :gorilla: 🦍
ab :koala: 🐨
ab :lady_beetle: 🐞
ab :ox: 🐂
ab :dh: ⏃
ab :octocat: 
ab :turtle: 🐢
ab :rhino: 🦏
ab :zombie: 🧟
ab :maple_leaf: 🍁
ab :tree: 🌳
ab :clover: 🍀
ab :alien: 👽
ab :flying_saucer: 🛸
ab :chocolate: 🍫
ab :doughnut: 🍩
ab :cookie: 🍪
ab :pear: 🍐
ab :locomotive: 🚂
ab :helicopter: 🚁
ab :game: 🎮
ab :island: 🏝
ab :performing_arts: 🎭
ab :degree: \u02DA
ab :filled: 🔲
ab :gift: 🎁
ab :warning: ⚠️
ab :no: 🚫
ab :biohazard: ☣️
ab :radioactive: ☢️
ab :key: 🔑
ab :shield: 🛡️
ab :beetle: 🐞
ab :kite: 🪁
ab :fire: 🔥
ab :diamond: 💎
ab :notebook: 📔
ab :locked: 🔒
ab :unlocked: 🔓
ab :8ball: 🎱
ab :100: 💯
ab :joker: 🃏
ab :bell: 🔔
ab :balloon: 🎈
ab :bullseye: 🎯
ab :medal: 🥇
ab :trophy: 🏆
ab :anchor: ⚓
ab :moai: 🗿
ab :pencil: ✏️
ab :pen: 🖊️
ab :note: 📝
ab :stethoscope: 🩺
ab :thread: 🧵
ab :love_letter: 💌
ab :hourglass: ⏳
ab :watch: ⌚
ab :clock: ⏰
ab :stopwatch: ⏱️
ab :calendar: 🗓
ab :clipboard: 📋
ab :money: 💰
ab :coffee: ☕
ab :strawberry: 🍓
ab :hamburger: 🍔
ab :pizza: 🍕
ab :french_fries: 🍟
ab :mushroom: 🍄
ab :tomato: 🍅
ab :t_rex: 🦖
ab :sauropod: 🦕
ab :separator_lb: 
ab :separator_rb: 
ab :separator_lt: 
ab :separator_rt: 
ab :separator_lst: ◀
ab :separator_rst: ▶
ab :separator_ltt: ❮
ab :separator_rtt: ❯
ab :ellipsis: …
ab :1: ❶
ab :2: ❷
ab :3: ❸
ab :4: ❹
ab :5: ❺
ab :6: ❻
ab :7: ❼
ab :8: ❽
ab :9: ❾
ab :10: ❿
ab :aries: ♈
ab :taurus: ♉
ab :gemini: ♊
ab :cancer: ♋
ab :leo: ♌
ab :virgo: ♍
ab :libra: ♎
ab :scorpio: ♏
ab :sagittarius: ♐
ab :capricorn: ♑
ab :aquarius: ♒
ab :pisces: ♓
]])
-- }}}

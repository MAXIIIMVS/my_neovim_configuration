local home = os.getenv("HOME")
local utils = require("utils")
local g = vim.g
local o = vim.o
local w = vim.wo
local b = vim.bo

-- Fundamental {{{
g.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal" -- removed blank
w.number = true
w.relativenumber = true
w.signcolumn = "yes:1"
o.fileencodings = "utf-8,sjis,euc-jp,latin"
o.encoding = "utf-8"
o.title = true
o.autoindent = true
o.hlsearch = true
o.incsearch = true
o.smartcase = true
o.showcmd = true
o.cmdheight = 0
o.laststatus = 3
vim.cmd("set statusline=%{reg_recording()}")
vim.cmd("set statusline+=%=%{&modified?'🟢':''}")
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
o.lazyredraw = true
o.ignorecase = true -- NOTE: I'm not sure about this or smartcase
o.backspace = "start,eol,indent"
o.path = o.path .. "**" -- or w.path, IDK
o.wildignore = o.wildignore .. "*/node_modules/*"

-- Turn off paste mode when leaving insert
vim.cmd("autocmd InsertLeave * set nopaste")

-- hide tmux
-- vim.cmd("autocmd VimEnter,VimLeave * silent !tmux set status")

-- Add asterisks in block comments
b.formatoptions = b.formatoptions .. "r"
--}}}

-- Syntax theme "{{{
-----------------------------------------------------------------------
-- true color
if vim.fn.exists("&termguicolors") == 1 and vim.fn.exists("&winblend") then
	vim.cmd("syntax enable")
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
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = home .. "/.config/undodir"
vim.opt.undofile = true
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
vim.cmd([[
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

vim.cmd([[
if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
]])

utils.create_augroup({
	{ "WinEnter", "*", "set", "cul" },
	{ "WinLeave", "*", "set", "nocul" },
}, "BgHighlight")

vim.cmd.highlight("VertSplit guifg=#32afff")
-- }}}

-- format files when using :wq and not using sync in lsp formatting
-- vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- emoji shortcuts {{{
-- ---------------------------------------------------------------------
vim.cmd([[
ab :check_mark: ✔
ab :pi: 𝞹
ab :right: ➡
ab :left: ⬅
ab :up: ⬆
ab :down: ⬇
ab :ninja: 🥷
ab :dh: ⏃
ab :octocat: 
ab :degree: \u02DA
ab :filled: 🔲
ab :biohazard: ☣️
ab :radioactive: ☢️
ab :kite: 🪁
ab :diamond: 💎
ab :bullseye: 🎯
ab :anchor: ⚓
ab :note: 📝
ab :stethoscope: 🩺
ab :thread: 🧵
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
ab :book_icon: 
ab :journal: 
ab :lamp: 
ab :note_taking: 
ab :task_management: 陼
ab :empty_square: 
ab :done: 
ab :filled_square: 
ab :bin: 
ab :github: 
ab :monitoring: 
ab :frozen: 
ab :earth: 
]])
-- }}}

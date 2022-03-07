-- TODO: remove unused variables
local utils = require('utils')
local g = vim.g
local o = vim.o
local w = vim.wo
local b = vim.bo
local cmd = vim.cmd

-- Fundamental {{{
-- NOTE: I'm not sure about this, remove if not necessary
cmd('autocmd!') -- Remove ALL autocommands for the current group.
-- cmd('scriptencoding utf-8') -- FIX:
w.number = true
w.relativenumber = true
w.signcolumn= 'number'
cmd('syntax on')
cmd('syntax enable')
o.fileencodings= 'utf-8,sjis,euc-jp,latin'
o.encoding= 'utf-8'
o.title = true
o.autoindent = true
o.backup = false
o.hlsearch = true
o.incsearch = true
o.smartcase = true
o.showcmd = true
o.cmdheight = 1
o.laststatus = 2
o.scrolloff= 10 -- NOTE: or w.scrolloff = 10, check it
b.expandtab = true -- space instead of tab

-- incremental substitution (neovim)
if vim.fn.has("nvim") == 1 then
  o.inccommand= 'split'
end

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
-- xterm-bracketed-paste
-- set t_BE= -- NOTE: I don't know how to set this

o.showcmd = false
o.ruler = false
o.showmatch = false
o.lazyredraw = true
o.ignorecase = true -- NOTE: I'm not sure about this or smartcase
o.smarttab = true
cmd('filetype plugin indent on')
b.shiftwidth = 2
b.tabstop = 2
b.ai = true
b.si = true
o.backspace= "start,eol,indent"
o.path = o.path .. "**" -- or w.path, IDK
o.wildignore= o.wildignore .. "*/node_modules/*"

-- Turn off paste mode when leaving insert
cmd('autocmd InsertLeave * set nopaste')

-- Add asterisks in block comments
b.formatoptions = b.formatoptions .. "r"
--}}}


-- Highlights {{{
-----------------------------------------------------------------------
w.cursorline = true

-- Set cursor line color on visual mode
-- NOTE: I'm not sure about syntax and the if statement
cmd([[highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40]])
cmd([[highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000]])

cmd([[
if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
]])

utils.create_augroup({
    {'WinEnter', '*', 'set', 'cul'},
    {'WinLeave', '*', 'set', 'nocul'}
}, 'BgHighlight')
-- }}}

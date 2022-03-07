local cmd = vim.cmd
local g = vim.g
local o = vim.o
local w = vim.wo
local b = vim.bo
local utils = require('utils')
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
b.filetype = 'plugin, indent on'
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



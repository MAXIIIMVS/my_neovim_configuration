local signs = {
	Error = " ",
	Warn = " ",
	Hint = "󰌶 ",
	Info = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local DiagnosticsConfig = vim.diagnostic.config()
local DiagnosticsEnabled = true
function ToggleDiagnostics()
	if not DiagnosticsEnabled then
		vim.diagnostic.config(DiagnosticsConfig)
		DiagnosticsEnabled = true
	else
		DiagnosticsConfig = vim.diagnostic.config()
		vim.diagnostic.config({
			virtual_text = false,
			sign = true,
			float = false,
			update_in_insert = false,
			severity_sort = false,
			underline = true,
		})
		DiagnosticsEnabled = false
	end
end

-- Auto commands and functions {{{
vim.cmd([[
nmap <C-_> gcc
xmap <C-_> gc
imap <C-_> <ESC>gcc

autocmd FileType template set filetype=html

" dadbod completion with cmp
" autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
au FileType * set fo-=c fo-=r fo-=o

autocmd FileType TelescopePrompt,dashboard setlocal nocursorline

" Automatically open Quickfix window if there are errors after :make
augroup auto_open_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END

autocmd User TermdebugStartPost lua vim.g.termdebug_running = true
autocmd User TermdebugStopPost lua vim.g.termdebug_running = false
autocmd TermClose * lua vim.g.termdebug_running = false

let g:termdebug_wide=1
let g:termdebug_map_K = 0
" let g:termdebug_disasm_window = 15

autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif

if has('nvim')
  augroup hide_terminal_numbers
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber nospell
  augroup END
else
  augroup hide_terminal_numbers
    autocmd!
    autocmd BufEnter term://* setlocal nonumber norelativenumber nospell
  augroup END
endif

augroup CmdHeight
    autocmd!
    autocmd CmdlineEnter * if &cmdheight == 0 | let g:cmdheight_prev = 0 | set cmdheight=1 | endif
    autocmd CmdlineLeave * if exists('g:cmdheight_prev') && g:cmdheight_prev == 0 | set cmdheight=0 | unlet! g:cmdheight_prev | endif
augroup END

" hide tmux
" autocmd VimEnter,VimLeave * silent !tmux set status
" autocmd VimLeave * silent !tmux set -g status-style bg=default

augroup sync_tmux
    autocmd!
    autocmd VimEnter * lua sync_statusline_with_tmux()
augroup END

let g:first_color_scheme_change = 1

function! SyncTmuxOnColorSchemeChange()
    if g:first_color_scheme_change
        let g:first_color_scheme_change = 0
    else
        augroup sync_all
          autocmd!
          autocmd ColorScheme * lua sync_statusline_with_tmux()
        augroup END
    endif
endfunction

autocmd BufEnter * call SyncTmuxOnColorSchemeChange()

" netrw settings and functions
" let g:netrw_list_hide= netrw_gitignore#Hide()
" let s:treedepthstring     = "│ "
" let g:netrw_hide = 1
" let g:netrw_altv=1
autocmd FileType netrw silent! nnoremap <buffer> <nowait> q :silent q<CR><silent>
autocmd FileType netrw silent! nnoremap <buffer> <nowait> ;q :silent q<CR><silent>
autocmd FileType netrw silent! nnoremap <buffer> <nowait> ;; :silent q<CR><silent>
autocmd FileType netrw silent! nnoremap <buffer> <nowait> ;x :silent q<CR><silent>
autocmd FileType netrw setl bufhidden=wipe

augroup NetrwSettings
  autocmd!
  autocmd WinClosed * if &filetype == 'netrw' | let g:NetrwIsOpen = 0 | endif
augroup END

let g:NetrwIsOpen=0

function! CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      silent! execute 'bwipeout ' . bufn
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      let g:NetrwIsOpen=0
      return
    endif
  endfor
endfunction

augroup closeOnOpen
  autocmd!
  autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END

function! ToggleNetrw()
    let g:netrw_winsize = -40
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore %:p:h
    endif
endfunction

" emojis
ab :pi: 𝞹
ab :micro: μ
ab :dh: ⏃
ab :degree: \u02DA
ab :bullseye: 🎯
ab :note: 📝
ab :separator_ltt: ❮
ab :separator_rtt: ❯
ab :degrees: °
]])
-- }}}

-- Fundamental {{{
vim.o.list = true
vim.o.listchars = "trail:,nbsp:.,precedes:❮,extends:❯,tab:  "
vim.g.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal" -- removed blank
vim.wo.spell = true
vim.o.spellcapcheck = ""
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes:1"
vim.o.fileencodings = "utf-8,sjis,euc-jp,latin"
vim.o.encoding = "utf-8"
vim.o.title = true
vim.o.autoindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showcmd = true
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.scrolloff = 4
vim.o.timeoutlen = 300
vim.o.inccommand = "split"
vim.o.ruler = false
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.lazyredraw = false
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.o.backspace = "start,eol,indent"
vim.o.path = vim.o.path .. "**" -- or vim.wo.path, IDK
vim.o.wildignore = vim.o.wildignore .. "*/node_modules/*,tags"

-- Syntax theme "{{{
-----------------------------------------------------------------------
if vim.fn.exists("&termguicolors") == 1 and vim.fn.exists("&winblend") then
	vim.cmd("syntax enable")
	vim.o.termguicolors = true
	vim.o.wildoptions = "pum"
	vim.wo.winblend = 0
	vim.o.pumblend = 0
	vim.o.background = "dark"
end
-- }}}

-- Settings {{{
-- ---------------------------------------------------------------------
-- vim.o.omnifunc = 'syntaxcomplete#Complete'
vim.wo.winblend = 0
vim.o.pumblend = 0
vim.o.errorbells = false
vim.o.belloff = "all"
vim.o.confirm = true
vim.opt.guifont = "FiraCode Nerd Font Mono Medium"
vim.g.scrollopt = "ver,hor,jump"
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.autoread = true
vim.bo.swapfile = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/undodir"
vim.opt.undofile = true
vim.o.showmode = true
vim.bo.textwidth = 80
-- vim.wo.colorcolumn = "80"
vim.wo.linebreak = true
vim.o.autochdir = true
vim.o.hidden = true
vim.o.wildmode = "full"
vim.o.wildmenu = true
vim.g.wildmenu = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 200
vim.wo.foldenable = true
vim.o.foldlevelstart = 99
-- vim.wo.foldnestmax = 10
vim.wo.foldmethod = "indent" -- manual, indent, syntax, marker, expr, diff
vim.wo.conceallevel = 0
vim.g.python3_host_prog = "/usr/bin/python3"

-- vim.o.smarttab = true
-- b.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
-- vim.o.softtabstop = 2
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.breakindent = true
-- vim.o.expandtab = true
-- vim.bo.expandtab = true
vim.o.nrformats = "bin,octal,hex"

vim.o.fillchars = "eob: "
-- }}}

-- Netrw {{{
vim.g.netrw_banner = false
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_winsize = -40
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = false
vim.g.netrw_liststyle = 3
-- vim.g.netrw_hide = true
-- }}}

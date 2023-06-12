local home = os.getenv("HOME")
local utils = require("utils")

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- Auto commands and functions {{{
vim.cmd([[
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" ToggleTerm
autocmd! TermOpen term://* lua set_terminal_keymaps()

" read calendar credentials
source ~/.config/nvim/credentials.vim

" hide tmux
" autocmd VimEnter,VimLeave * silent !tmux set status

" I don't know what these line do
au FocusGained,BufEnter * :silent! !
" hi CursorLine cterm=NONE ctermbg=232
" autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None
" autocmd InsertLeave * highlight  CursorLine ctermbg=232

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

" NvimTree
autocmd FileType NvimTree nnoremap <buffer> <nowait> ;q <cmd>NvimTreeToggle<CR>
autocmd FileType NvimTree nnoremap <buffer> <nowait> ;; <cmd>NvimTreeToggle<CR>

" netrw settings and functions
" let g:netrw_list_hide= netrw_gitignore#Hide()
" let s:treedepthstring     = "│ "
" let g:netrw_hide = 1
autocmd FileType netrw nnoremap <buffer> <nowait> q :call ToggleNetrw()<CR>
autocmd FileType netrw nnoremap <buffer> <nowait> ;q :call ToggleNetrw()<CR>
autocmd FileType netrw nnoremap <buffer> <nowait> ;; :call ToggleNetrw()<CR>
autocmd FileType netrw setl bufhidden=wipe
autocmd FileType netrw nnoremap <buffer> <Backspace> <Plug>NetrwBrowseUpDir
function! CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      " silent! execute 'bwipeout ' . bufn
      " NOTE: I replaced the previous line with next one; This lets the
      " ToggleNetrw to take care of wiping out the buffer (netrw in this case)
      silent! execute ':call ToggleNetrw()<CR>'
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      return
    endif
  endfor
endfunction
augroup closeOnOpen
  autocmd!
  autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END

let g:NetrwIsOpen=0

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
        " silent Lexplore
        silent Lexplore %:p:h
    endif
endfunction

" vimwiki settings
let g:vimwiki_list = [{'path': '~/notes/wiki/',  'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown',  '.mkd': 'markdown',  '.wiki': 'media'}
let g:vimwiki_global_ext = 0

" emojis
ab :pi: 𝞹
ab :micro: μ
ab :dh: ⏃
ab :degree: \u02DA
ab :biohazard: ☣️
ab :radioactive: ☢️
ab :bullseye: 🎯
ab :note: 📝
ab :kite: 🩺
ab :thread: 🧵
ab :sauropod: 🦕
ab :separator_ltt: ❮
ab :separator_rtt: ❯
]])
-- }}}

-- Fundamental {{{
vim.g.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal" -- removed blank
vim.wo.spell = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes:1"
vim.o.fileencodings = "utf-8,sjis,euc-jp,latin"
vim.o.encoding = "utf-8"
vim.o.title = true
vim.o.autoindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.showcmd = true
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.scrolloff = 4
vim.o.timeoutlen = 500
-- incremental substitution (neovim)
if vim.fn.has("nvim") == 1 then
	vim.o.inccommand = "split"
end

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
-- xterm-bracketed-paste
-- set t_BE= -- NOTE: I don't know how to set this
vim.o.ruler = false
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.lazyredraw = false
vim.o.ignorecase = true
vim.o.backspace = "start,eol,indent"
vim.o.path = vim.o.path .. "**" -- or vim.wo.path, IDK
vim.o.wildignore = vim.o.wildignore .. "*/node_modules/*"

-- Add asterisks in block comments
vim.bo.formatoptions = vim.bo.formatoptions .. "r"
--}}}

-- Syntax theme "{{{
-----------------------------------------------------------------------
-- true color
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
vim.opt.guifont = "FiraMono Nerd Font Medium"
vim.go.t_Co = "256"
-- vim.go.t_ut = ""
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.autoread = true
vim.bo.swapfile = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = home .. "/.config/undodir"
vim.opt.undofile = true
vim.o.showmode = true
vim.bo.textwidth = 79
-- vim.wo.colorcolumn = "79"
vim.wo.linebreak = true
vim.o.autochdir = true
vim.o.hidden = true
-- cmd('highlight ColorColumn ctermbg=DarkBlue')
vim.o.wildmode = "full"
vim.o.wildmenu = true
vim.g.wildmenu = true
vim.o.splitright = true
vim.o.updatetime = 500
vim.wo.foldenable = true
vim.o.foldlevelstart = 99
-- vim.wo.foldnestmax = 10
vim.wo.foldmethod = "indent" -- manual, indent, syntax, marker, expr, diff
vim.wo.conceallevel = 0
-- python3 path: change if it's necessary, -- NOTE: I'm not sure about this
vim.g.python3_host_prog = "/usr/bin/python3"
-- cmd('autocmd FileType javascript set filetype=javascriptreact')
-- cmd('autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact')
-- cmd('autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact')

-- vim.o.smarttab = true
-- b.smartindent = true
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.breakindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
-- vim.o.nrformats = "alpha,bin,hex"

-- vim.cmd[[colorscheme aurora]]
-- hide tildes (only vim), this doesn't work for nvim-tree
-- vim.wo.fillchars = "eob: "
-- or put this after colorscheme (vim & nvim), works for nvim-tree
-- vim.cmd("hi NonText guifg=bg")
-- }}}

-- Highlights {{{
-----------------------------------------------------------------------
vim.o.cursorlineopt = "number" -- disable cursorline in transparent mode

utils.create_augroup({
	{ "WinEnter", "*", "set", "cul" },
	{ "WinLeave", "*", "set", "nocul" },
}, "BgHighlight")

-- vim.cmd.highlight("VertSplit guifg=#32afff")
-- }}}

-- format files when using :wq and not using sync in lsp formatting
-- vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- Netrw {{{
vim.g.netrw_banner = false
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_winsize = -40
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = false
vim.g.netrw_liststyle = 3
-- vim.g.netrw_hide = true
-- }}}

-- vimtex {{{
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk" -- default compiler
vim.g.vimtex_format_enabled = true
vim.g.texflavor = "latex"
vim.cmd([[let maplocalleader = "\<space>"]])
-- }}}

-- VimWiki {{{
vim.g.vimwiki_listsyms = " .oOx"
-- }}}

-- vim-rooter {{{
vim.g.rooter_silent_chdir = true
vim.g.rooter_resolve_links = true
vim.g.rooter_cd_cmd = "lcd"
vim.g.rooter_change_directory_for_non_project_files = "current"
-- }}}

-- clever-f {{{
-- vim.g.clever_f_ignore_case = true
vim.g.clever_f_smart_case = true
-- vim.g.clever_f_mark_char_color = "HopNextKey2"
-- }}}

-- Calendar.vim {{{
-- vim.g.calendar_week_number = true
-- vim.g.calendar_date_month_name = true
-- vim.g.calendar_task = true
vim.g.calendar_google_calendar = true
vim.g.calendar_google_task = true
vim.g.calendar_date_full_month_name = true
vim.g.calendar_event_start_time = true
vim.g.calendar_skip_event_delete_confirm = true
vim.g.calendar_skip_task_delete_confirm = true
vim.g.calendar_skip_task_clear_completed_confirm = true
vim.g.calendar_task_width = 45
vim.g.calendar_task_delete = true
-- vim.g.calendar_cache_directory = "~/notes/calendar.vim/"
-- }}}

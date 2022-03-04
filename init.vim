" Fundamental {{{
" ---------------------------------------------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
set relativenumber
set signcolumn=number " yes or no or number

syntax on
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch incsearch smartcase
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

"}}}

" Highlights {{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
"}}}

" File types {{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

" TODO: what the hell is this?
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports {{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------
" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  " let g:neosolarized_termtrans=1
  " runtime ./colors/NeoSolarized.vim
  " colorscheme NeoSolarized
endif
"}}}

" Settings {{{
" ---------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete
set noerrorbells
" set visualbell
set belloff=all
set confirm
" set guifont=firaCode
set guifont=FiraCode\ Nerd\ Font
set t_Co=256
" set linespace=0
set clipboard=unnamedplus
set mouse=a
" reload files changed outside of Vim not currently modified in Vim (needs
" below)
set autoread
set noswapfile " don't create temp files
set softtabstop=2
set showmode " statusline indicates insert or normal mode

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
 " set ttyfast

set showmatch " highlight matching parens, braces, brackets, etc
" Wrap lines at convenient points, avoid wrapping a line in the middle of a word
set linebreak
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir
set hidden
set colorcolumn=80
" highlight ColorColumn ctermbg=DarkBlue
" set textwidth=79
" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full
" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set statusline=%F
set updatetime=100 " wait 100ms before writing swap files
set foldenable "Enable folding
"Open most of the folds by default. If set to 0, all folds will be closed.
set foldlevelstart=10
"Folds can be nested. Setting a max value protects you from too many folds.
set foldnestmax=10
"Defines the type of folding.
" values are manual, indent, syntax, marker, expr, diff
set foldmethod=manual
" to have project specific configuration inside a .exrc file at the root of
" your project.
set exrc
set secure
set conceallevel=0
" Rust save on format
let g:rustfmt_autosave = 1
" python3 path: chage if it's necessary or use .exrc file
let g:python3_host_prog = '/usr/bin/python3'
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !
hi CursorLine cterm=NONE ctermbg=232
autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None
autocmd InsertLeave * highlight  CursorLine ctermbg=232

" format document on save: eslint
" autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
" }}}

colorscheme aurora
" to make background transparent, this should go under colorscheme
" hi Normal guibg=NONE ctermbg=NONE

" emoji shortcuts {{{
" ---------------------------------------------------------------------
ab :check: ✅
ab :cross: ❌
ab :right: ➡
ab :left: ⬅
ab :up: ⬆
ab :down: ⬇
ab :right_finger: 👉
ab :left_finger: 👈
ab :up_finger: 👆
ab :down_finger: 👇
ab :bulb: 💡
ab :pushpin: 📌
ab :bomb: 💣
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :telephone: 📞
ab :email: 📧
ab :computer: 💻
ab :rocket: 🚀
ab :crown: 👑
ab :robot: 🤖
ab :poop: 💩
ab :ghost: 👻
ab :wine_glass: 🍷
ab :mobile_phone: 📱
ab :red_heart: ❤️
ab :skull: 💀
ab :alien: 👽
ab :degree: \u02DA
ab :black_square_button: 🔲
ab :empty: 🔳
ab :left_bold_separator: 
ab :right_bold_separator: 
ab :left_thin_separator: 
ab :right_thin_separator: 
ab :small_left_bold: ◀
ab :small_right_bold: ▶
ab :small_right_thin: ❮
ab :small_right_thin: ❯

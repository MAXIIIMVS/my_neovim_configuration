if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'szw/vim-maximizer'
Plug 'luochen1990/rainbow'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'rafalbromirski/vim-aurora'
Plug 'ayu-theme/ayu-vim'
Plug 'srcery-colors/srcery-vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'tomasiser/vim-code-dark'
" Check this out
" Plug 'vim-test/vim-test'
" And this one
" Plug 'mg979/vim-visual-multi'
Plug 'jparise/vim-graphql'
" TODO: is vim-prisma necessary?
Plug 'pantharshit00/vim-prisma'
Plug 't9md/vim-choosewin'
Plug 'puremourning/vimspector'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
" Plug 'tpope/vim-capslock'
" Plug 'github/copilot.vim'
" Plug 'preservim/tagbar'
" Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

if has("nvim")
  Plug 'phaazon/hop.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }
  Plug 'folke/lsp-colors.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  " Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'folke/todo-comments.nvim'
  Plug 'onsails/lspkind-nvim'
endif

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" VimDevIcons: add icons to your plugins
Plug 'ryanoasis/vim-devicons'

call plug#end()

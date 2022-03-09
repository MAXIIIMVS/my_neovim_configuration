return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'rafalbromirski/vim-aurora'}
  -- TODO: Install nvim-web-devicons
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = "require('exvimmer/treesitter-config')"
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    event = "BufWinEnter",
    config = "require('exvimmer/lualine-config')"
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    event = "BufWinEnter",
    config = "require('exvimmer/bufferline-config')"
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = "NvimTreeToggle",
    config = "require('exvimmer/nvim-tree-config')"
  }
  use {'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter"}
  use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"}
  use {'windwp/nvim-autopairs', config = "require('exvimmer/autopairs-config')", after = "nvim-cmp"}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    cmd = "Telescope",
    config = "require('exvimmer/telescope-config')"
  }
  use {'neovim/nvim-lspconfig', config = "require('exvimmer/lsp')"}
  use {'williamboman/nvim-lsp-installer'}
  -- NOTE: tami5/lspsaga.nvim is the maintained version
  use {'tami5/lspsaga.nvim', config = "require('exvimmer/lspsaga-config')"}
  use {'onsails/lspkind-nvim'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/nvim-cmp'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {"terrortylor/nvim-comment", config = "require('exvimmer/comment-config')"}
  use {'norcalli/nvim-colorizer.lua', config = "require('exvimmer/colorizer-config')", event = "BufRead"}
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = "require('exvimmer/blankline-config')",
    event = "BufRead"
  }
  use {'jose-elias-alvarez/null-ls.nvim', config = "require('exvimmer/null-ls-config')"}
  use {'ctrlpvim/ctrlp.vim'}
  use {'folke/todo-comments.nvim', config = "require('exvimmer/comment-config')"}
  use 'szw/vim-maximizer'
  -- use 'styled-components/vim-styled-components', { 'branch': 'main' }
  -- ues 't9md/vim-choosewin'
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-speeddating'}
  use {'ayu-theme/ayu-vim', config = "require('exvimmer/ayu-config')"}
  use {'srcery-colors/srcery-vim'} -- NOTE: if necessary, use gruvbox-config
  use {'lifepillar/vim-gruvbox8', config = "require('exvimmer/gruvbox-config')"}
  use {'tomasiser/vim-code-dark'}
  use {
    'folke/tokyonight.nvim',
    event = "VimEnter",
    config = "require('exvimmer/tokyonight-config')"
  }
  use {'nvim-lua/popup.nvim'}
  use {'folke/lsp-colors.nvim', config = "require('exvimmer/lsp-colors-config')"}
  use {'phaazon/hop.nvim', config = "require('exvimmer/hop-config')"}
  -- use {'simrat39/rust-tools.nvim'}
  -- use {'puremourning/vimspector', config = "require('exvimmer/vimspector-config')"}
end)

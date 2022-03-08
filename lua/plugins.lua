return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'rafalbromirski/vim-aurora'}
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
  --use {'windwp/nvim-autopairs', config = "require('exvimmer/autopairs-config')", after = "nvim-cmp"}
  -- TODO: replace with the previous one after installing nvim-cmp
  use {'windwp/nvim-autopairs', config = "require('exvimmer/autopairs-config')"}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    cmd = "Telescope",
    config = "require('exvimmer/telescope-config')"
  }
  use {'neovim/nvim-lspconfig', config = "require('exvimmer/lsp')"}
  use {'williamboman/nvim-lsp-installer'}
  use {'onsails/lspkind-nvim'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/nvim-cmp'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
end)

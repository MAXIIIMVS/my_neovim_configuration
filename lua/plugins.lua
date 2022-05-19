local u = require('utils')

-- automatically install and set up packer.nvim on any machine you clone your
-- configuration to
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use {'rafalbromirski/vim-aurora'}
  use {'kyazdani42/nvim-web-devicons', config = u.get_setup('nvim-web-devicons')}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = u.get_setup('treesitter')
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    event = "VimEnter",
    config = u.get_setup('lualine')
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    event = "BufWinEnter",
    config = u.get_setup('bufferline')
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = "NvimTreeToggle",
    config = u.get_setup('nvim-tree')
  }
  use {'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter"}
  use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"}
  use {'windwp/nvim-autopairs', config = u.get_setup('autopairs'), after = "nvim-cmp"}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    cmd = "Telescope",
    config = u.get_setup('telescope')
  }
  use {'neovim/nvim-lspconfig', config = "require('exvimmer/lsp')"}
  use {'williamboman/nvim-lsp-installer'}
  -- NOTE: tami5/lspsaga.nvim is the maintained version
  use {'tami5/lspsaga.nvim', config = u.get_setup('lspsaga')}
  use {'onsails/lspkind-nvim'}
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {"terrortylor/nvim-comment", config = u.get_setup('comment')}
  use {'folke/todo-comments.nvim', config = u.get_setup('comment')}
  use {'norcalli/nvim-colorizer.lua', config = u.get_setup('colorizer'), event = "BufRead"}
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = "require('exvimmer/blankline-config')",
    event = "BufRead"
  }
  use {'jose-elias-alvarez/null-ls.nvim', config = u.get_setup('null-ls')}
  -- use {'ctrlpvim/ctrlp.vim'}
  use 'szw/vim-maximizer'
  -- use 'styled-components/vim-styled-components', { 'branch': 'main' }
  -- ues 't9md/vim-choosewin'
  use {'tpope/vim-surround'}
  -- use {'tpope/vim-repeat'}
  use {'tpope/vim-speeddating'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-rhubarb'}
  use {'tomasiser/vim-code-dark'}
  use {
    'folke/tokyonight.nvim',
    event = "VimEnter",
    config = u.get_setup('tokyonight')
  }
  use {'nvim-lua/popup.nvim'}
  use {'folke/lsp-colors.nvim', config = u.get_setup('lsp-colors')}
  use {'phaazon/hop.nvim', config = u.get_setup('hop')}
  use {"akinsho/toggleterm.nvim", config = u.get_setup('toggleterm')}
  -- use {'simrat39/rust-tools.nvim'}
  use {'puremourning/vimspector', config = u.get_setup('vimspector')}
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = u.get_setup('gitsigns')
  }
  use {"rebelot/kanagawa.nvim", config = u.get_setup('kanagawa')}
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = u.get_setup('catppuccin')
  })

  -- put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'rafalbromirski/vim-aurora'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = "require('exvimmer/treesitter-config')"
  }
end)

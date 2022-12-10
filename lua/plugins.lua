local u = require('utils')

-- automatically install and set up packer.nvim on any machine you clone your
-- configuration to
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup({ function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'kyazdani42/nvim-web-devicons', config = u.get_setup('nvim-web-devicons') }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = u.get_setup('treesitter')
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
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
  use { 'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter" }
  use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
  use { 'windwp/nvim-autopairs', config = u.get_setup('autopairs'), after = "nvim-cmp" }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    cmd = "Telescope",
    config = u.get_setup('telescope')
  }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { 'neovim/nvim-lspconfig', config = "require('exvimmer/lsp')" }
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = u.get_setup("lspsaga")
  })
  use { 'onsails/lspkind-nvim' }
  -- use { "lukas-reineke/lsp-format.nvim" }
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = u.get_setup("null_ls"),
    requires = { "nvim-lua/plenary.nvim" },
  })
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { "terrortylor/nvim-comment", config = u.get_setup('comment') }
  use { 'folke/todo-comments.nvim', config = u.get_setup('comment') }
  use { 'folke/lsp-colors.nvim', config = u.get_setup('lsp-colors') }
  use { "folke/which-key.nvim", config = u.get_setup('which-key') }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end
  }
  use { 'NvChad/nvim-colorizer.lua', config = u.get_setup('colorizer'), event = "BufRead" }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = "require('exvimmer/blankline')",
    event = "BufRead"
  }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rhubarb' }
  use { 'nvim-lua/popup.nvim' }
  use { 'phaazon/hop.nvim', config = u.get_setup('hop') }
  -- use {'simrat39/rust-tools.nvim'}
  -- use { 'puremourning/vimspector', config = u.get_setup('vimspector') }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = u.get_setup('gitsigns')
  }

  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = u.get_setup('catppuccin')
  })
  use { 'KabbAmine/vCoolor.vim' }

  -- put this at the end, after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})

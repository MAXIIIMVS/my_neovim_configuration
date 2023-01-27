-- automatically install and set up packer.nvim on any machine you clone your
-- configuration to
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup({
	function(use)
		use({ "wbthomason/packer.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
		use({ "windwp/nvim-ts-autotag", event = "InsertEnter", after = "nvim-treesitter" })
		use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
		use({ "windwp/nvim-autopairs", after = "nvim-cmp" })
		use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({ "xiyaowong/telescope-emoji.nvim" })
		use({ "adoyle-h/lsp-toggle.nvim" })
		use({ "williamboman/mason.nvim" })
		use({ "williamboman/mason-lspconfig.nvim" })
		use({ "neovim/nvim-lspconfig", config = "require('exvimmer/lsp')" })
		use({ "glepnir/lspsaga.nvim", branch = "main" })
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "hrsh7th/nvim-cmp" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "L3MON4D3/LuaSnip" })
		use({ "saadparwaiz1/cmp_luasnip" })
		use("rafamadriz/friendly-snippets")
		use({ "terrortylor/nvim-comment" })
		use({ "folke/todo-comments.nvim" })
		use({ "folke/lsp-colors.nvim" })
		use({ "folke/which-key.nvim" })
		use({ "folke/zen-mode.nvim" })
		use({ "NvChad/nvim-colorizer.lua" })
		use({ "lukas-reineke/indent-blankline.nvim" })
		use({ "tpope/vim-surround" })
		use({ "tpope/vim-fugitive" })
		use({ "tpope/vim-rhubarb" })
		use({ "tpope/vim-rsi" })
		use({ "nvim-lua/popup.nvim" })
		use({ "phaazon/hop.nvim" })
		use({ "phaazon/mind.nvim", branch = "v2.2", requires = "nvim-lua/plenary.nvim" })
		-- use {'simrat39/rust-tools.nvim'}
		use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "catppuccin/nvim", as = "catppuccin" })
		use({ "KabbAmine/vCoolor.vim" })
		use("mbbill/undotree")

		-- put this at the end, after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})

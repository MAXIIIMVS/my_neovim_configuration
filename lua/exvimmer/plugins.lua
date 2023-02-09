local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-autopairs",
		},
	},
	{ "akinsho/bufferline.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-telescope/telescope.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "xiyaowong/telescope-emoji.nvim" },
	{ "adoyle-h/lsp-toggle.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "glepnir/lspsaga.nvim", branch = "main" },
	{ "glepnir/dashboard-nvim", event = "VimEnter" },
	{ "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
	},
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "folke/todo-comments.nvim" },
	{ "folke/lsp-colors.nvim" },
	{ "folke/which-key.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "folke/neodev.nvim" },
	{ "NvChad/nvim-colorizer.lua" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-rhubarb" },
	{ "tpope/vim-rsi" },
	{ "tpope/vim-obsession" },
	{ "tpope/vim-speeddating" },
	{ "phaazon/hop.nvim" },
	{
		"phaazon/mind.nvim",
		branch = "v2.2",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- {'simrat39/rust-tools.nvim'},
	{ "KabbAmine/vCoolor.vim" },
	{ "mbbill/undotree" },
}, {
	ui = {
		border = "single",
	},
})

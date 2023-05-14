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
	{ "adoyle-h/lsp-toggle.nvim" },
	{ "akinsho/bufferline.nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{ "famiu/bufdelete.nvim" },
	{ "folke/which-key.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "folke/neodev.nvim" },
	{ "glepnir/dashboard-nvim", event = "VimEnter" },
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			-- "onsails/lspkind.nvim",
		},
	},
	{ "hrsh7th/cmp-cmdline" }, -- I put this outside of dependencies, intentionally
	{ "itchyny/calendar.vim" },
	{ "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "kylechui/nvim-surround", config = true },
	{ "L3MON4D3/LuaSnip" },
	{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "mbbill/undotree" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
			"xiyaowong/telescope-emoji.nvim",
			"ghassan0/telescope-glyph.nvim",
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
		},
	},
	{ "numToStr/Comment.nvim" },
	{ "NvChad/nvim-colorizer.lua" },
	{ "phaazon/hop.nvim", config = true },
	{ "rafamadriz/friendly-snippets" },
	{ "ray-x/lsp_signature.nvim" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{ "tpope/vim-rsi" },
	{ "tpope/vim-obsession" },
	{ "tpope/vim-speeddating" },
	{ "vimwiki/vimwiki" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
}, {
	ui = {
		border = "single",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

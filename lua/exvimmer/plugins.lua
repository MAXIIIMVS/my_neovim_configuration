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

-- TODO: FIX: all dependency settings are wrong

return require("lazy").setup({
	{ "adoyle-h/lsp-toggle.nvim", event = "VeryLazy" },
	{ "airblade/vim-rooter" },
	{ "akinsho/bufferline.nvim", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{ "famiu/bufdelete.nvim", event = "VeryLazy" },
	{ "folke/which-key.nvim", lazy = true },
	{ "folke/zen-mode.nvim", even = "VeryLazy" },
	{ "folke/neodev.nvim", lazy = true },
	{ "glepnir/dashboard-nvim", event = "VimEnter" },
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		event = "VeryLazy",
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
	{ "hrsh7th/cmp-cmdline" },
	{ "itchyny/calendar.vim", event = "VeryLazy" },
	{ "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "L3MON4D3/LuaSnip", event = "VeryLazy" },
	{
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = "go",
	},
	{ "lervag/vimtex", event = "VeryLazy", ft = "tex" },
	{ "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
	{ "mbbill/undotree", event = "VeryLazy" },
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		event = "VeryLazy",
	},
	{ "neovim/nvim-lspconfig" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
			"xiyaowong/telescope-emoji.nvim",
			"ghassan0/telescope-glyph.nvim",
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-tree/nvim-tree.lua", event = "VeryLazy" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
		},
	},
	{ "numToStr/Comment.nvim", event = "VeryLazy" },
	{ "NvChad/nvim-colorizer.lua", event = "VeryLazy" },
	{ "phaazon/hop.nvim", config = true, event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets" },
	{ "ray-x/lsp_signature.nvim", lazy = true },
	{ "rcarriga/nvim-dap-ui", dependencies = {
		"mfussenegger/nvim-dap",
	}, event = "VeryLazy" },
	{ "rhysd/clever-f.vim", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "theHamsta/nvim-dap-virtual-text", dependencies = {
		"mfussenegger/nvim-dap",
	}, event = "VeryLazy" },
	{ "/tpope/vim-abolish", event = "VeryLazy" },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-rsi", event = "VeryLazy" },
	{ "tpope/vim-obsession", event = "VeryLazy" },
	{ "tpope/vim-speeddating", event = "VeryLazy" },
	{ "vimwiki/vimwiki", event = "VeryLazy" },
	{ "williamboman/mason.nvim", event = "VeryLazy" },
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

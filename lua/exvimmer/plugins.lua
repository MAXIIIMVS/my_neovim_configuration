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
	{
		"adoyle-h/lsp-toggle.nvim",
		event = "VeryLazy",
		opts = {
			create_cmds = true, -- Whether to create user commands
			telescope = true, -- Whether to load telescope extensions
		},
	},
	{ "airblade/vim-rooter" },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true, event = "VeryLazy" },
	-- {"akinsho/git-conflict.nvim"},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"echasnovski/mini.jump2d",
		opts = {
			mappings = {
				start_jumping = ";j",
			},
			view = {
				dim = true,
				n_steps_ahead = 1,
			},
			silent = true,
		},
		version = "*",
		event = "VeryLazy",
	},
	{ "famiu/bufdelete.nvim", event = "VeryLazy" },
	{ "folke/which-key.nvim", lazy = true },
	{ "folke/zen-mode.nvim", opts = { window = { width = 100 } }, even = "VeryLazy" },
	{ "folke/neodev.nvim", opts = {}, lazy = true },
	{ "ghassan0/telescope-glyph.nvim", dependencies = "nvim-telescope/telescope.nvim", event = "VeryLazy" },
	{ "glepnir/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"glepnir/lspsaga.nvim",
		lazy = true,
		branch = "main",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
	},
	{ "itchyny/calendar.vim", event = "VeryLazy" },
	{ "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },
	{ "KabbAmine/vCoolor.vim", event = "VeryLazy" },
	{
		"kylechui/nvim-surround",
		config = true,
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
		-- build = "make install_jsregexp",
	},
	{
		"leoluz/nvim-dap-go",
		config = true,
		event = "VeryLazy",
		ft = "go",
	},
	{ "lervag/vimtex", event = "VeryLazy", ft = "tex" },
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 200,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author> <author_mail>: <summary>",
		},
		event = "BufEnter",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			buftype_exclude = { "terminal", "nofile" },
			filetype_exclude = { "help", "dashboard", "NvimTree", "packer", "mason", "fugitive" },
			show_current_context = true,
			max_indent_increase = 1,
			context_patterns = {
				"class",
				"return",
				"function",
				"method",
				"^if",
				"^while",
				"jsx_element",
				"^for",
				"^object",
				"^table",
				"block",
				"arguments",
				"if_statement",
				"else_clause",
				"jsx_element",
				"jsx_self_closing_element",
				"try_statement",
				"catch_clause",
				"import_statement",
				"operation_type",
			},
		},
	},
	{ "mbbill/undotree", event = "VeryLazy" },
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		event = "VeryLazy",
	},
	{ "mxsdev/nvim-dap-vscode-js", event = "VeryLazy" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
	},
	{ "nvim-tree/nvim-web-devicons", config = true, lazy = true },
	{ "nvim-tree/nvim-tree.lua", lazy = true, dependencies = "nvim-tree/nvim-web-devicons" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", opts = { check_ts = true } },
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
		opts = { toggler = {
			line = "<C-_>",
		} },
	},
	{ "numToStr/Navigator.nvim", config = true, event = "VeryLazy" },
	{ "NvChad/nvim-colorizer.lua", event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets" },
	{ "ray-x/lsp_signature.nvim", opts = {
		hint_enable = false,
	}, event = "VeryLazy" },
	{ "rcarriga/nvim-dap-ui", config = true, event = "VeryLazy" },
	{ "rhysd/clever-f.vim", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip", dependencies = "hrsh7th/nvim-cmp" },
	-- {"simrat39/rust-tools.nvim"},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				win_options = {
					winblend = 0,
				},
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		-- config = true,
		event = "VeryLazy",
	},
	{ "/tpope/vim-abolish", event = "VeryLazy" },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-rsi", event = "VeryLazy" },
	{ "tpope/vim-obsession", event = "VeryLazy" },
	{ "tpope/vim-speeddating", event = "VeryLazy" },
	{ "vimwiki/vimwiki", event = "VeryLazy" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "xiyaowong/telescope-emoji.nvim", dependencies = "nvim-telescope/telescope.nvim", event = "VeryLazy" },
}, {
	ui = {
		border = "rounded",
	},
})

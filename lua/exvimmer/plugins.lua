-- ムスタファ ハヤティ
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
			create_cmds = true,
			telescope = true,
		},
	},
	{ "airblade/vim-rooter" },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "akinsho/toggleterm.nvim", version = "*", config = true, event = "VeryLazy" },
	-- {"akinsho/git-conflict.nvim"},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		opts = {
			conflict = { suffix = "", options = {} },
			quickfix = { suffix = "", options = {} },
		},
		event = "VeryLazy",
	},
	{
		"echasnovski/mini.indentscope",
		event = "UIEnter",
		version = false,
		opts = {
			options = {
				indent_at_cursor = true,
			},
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
			symbol = "┃",
		},
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
		version = false,
		event = "VeryLazy",
	},
	{
		"echasnovski/mini.move",
		version = false,
		opts = {
			mappings = {
				left = "<C-h>",
				right = "", -- disabled
				down = "<C-j>",
				up = "<C-k>",
				line_left = "<C-h>",
				line_right = "", -- disabled
				line_down = "<C-j>",
				line_up = "<C-k>",
			},
		},
		event = "VeryLazy",
	},
	{ "famiu/bufdelete.nvim", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			highlight = {
				multiline = false,
				multiline_context = 0,
				keyword = "fg",
				before = "",
				after = "",
			},
			keywords = {
				FIX = { color = "#FF3E00", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { color = "#FF1C7B", alt = { "LATER" } },
				NOTE = { color = "#0AF106", alt = { "INFO" } },
				HACK = { color = "#F0FD00" },
				WARN = { color = "#FBBF24", alt = { "WARNING", "XXX" } },
			},
		},
	},
	{ "folke/which-key.nvim", lazy = true },
	{ "folke/zen-mode.nvim", opts = { window = { width = 100 } }, even = "VeryLazy" },
	{ "folke/neodev.nvim", opts = {}, lazy = true },
	{ "ghassan0/telescope-glyph.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, event = "VeryLazy" },
	{ "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" } },
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
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{ "kristijanhusak/vim-dadbod-completion", event = "VeryLazy" },
	{
		"kylechui/nvim-surround",
		config = true,
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		version = "v2.*",
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
	-- {
	-- 	"microsoft/vscode-js-debug",
	-- 	lazy = true,
	-- 	-- build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	-- 	build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
	-- },
	-- {
	-- 	"mxsdev/nvim-dap-vscode-js",
	-- 	event = "VeryLazy",
	--
	-- 	opts = {
	-- 		debugger_path = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/js-debug-adapter",
	-- 		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
	-- 	},
	-- },
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
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
		opts = { toggler = {
			line = "<C-_>",
		} },
	},
	{ "numToStr/Navigator.nvim", opts = {}, event = "VeryLazy" },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				AARRGGBB = true,
				RRGGBBAA = true,
				css = true,
				css_fn = true,
				rgb_fn = true,
				hsl_fn = true,
				mode = "background",
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
			},
		},
		event = "VeryLazy",
	},
	{ "onsails/lspkind.nvim", dependencies = { "hrsh7th/nvim-cmp" } },
	{ "rafamadriz/friendly-snippets" },
	{ "ray-x/lsp_signature.nvim", opts = {
		hint_enable = false,
	}, event = "VeryLazy" },
	{
		"rcarriga/nvim-dap-ui",
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 7,
				},
				{
					elements = {
						{
							id = "breakpoints",
							size = 0.1,
						},
						{
							id = "stacks",
							size = 0.40,
						},
					},
					position = "left",
					size = 34,
				},
				{
					elements = {
						{
							id = "watches",
							size = 0.40,
						},
						{
							id = "scopes",
							size = 0.6,
						},
					},
					position = "right",
					size = 48,
				},
			},
		},
		event = "VeryLazy",
	},
	{ "rhysd/clever-f.vim", event = "VeryLazy" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
	-- {"simrat39/rust-tools.nvim"},
	{
		"theHamsta/nvim-dap-virtual-text",
		-- config = true,
		event = "VeryLazy",
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {
			transparent_background = false,
		},
	},
	{ "tpope/vim-abolish", event = "VeryLazy" },
	{ "tpope/vim-capslock", event = "VeryLazy" },
	{ "tpope/vim-dadbod", event = "VeryLazy" },
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
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", opts = { check_ts = true } },
	{ "xiyaowong/telescope-emoji.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, event = "VeryLazy" },
}, {
	ui = {
		border = "rounded",
	},
})

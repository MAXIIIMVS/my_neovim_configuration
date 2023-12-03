-- ムスタファ・ハヤティ
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
		"airblade/vim-rooter",
		init = function()
			vim.g.rooter_silent_chdir = true
			vim.g.rooter_resolve_links = true
			vim.g.rooter_cd_cmd = "lcd"
			vim.g.rooter_change_directory_for_non_project_files = "current"
		end,
		event = "VeryLazy",
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "Explorer",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
					{
						filetype = "netrw",
						text = "Netrw",
						highlight = "Directory",
						separator = false,
					},
					{
						filetype = "undotree",
						text = "Undo Tree",
						highlight = "Directory",
						separator = false,
					},
					{
						filetype = "sagaoutline",
						text = "Lspsaga Outline",
						highlight = "Directory",
						separator = false,
					},
				},
				sort_by = "insert_at_end",
				numbers = "ordinal",
				separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
				diagnostics = "nvim_lsp",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			float_opts = {
				border = "rounded",
			},
		},
		cmd = {
			"ToggleTerm",
			"ToggleTermSetName",
			"ToggleTermToggleAll",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"echasnovski/mini.bracketed",
		-- version = false,
		opts = {
			conflict = { suffix = "", options = {} },
			quickfix = { suffix = "", options = {} },
		},
		init = function()
			vim.cmd([[
				augroup diff_keys
				  autocmd!
				  autocmd OptionSet diff if &diff
				    \ | nnoremap <silent> ]c ]c
				    \ | nnoremap <silent> [c [c
				    \ | else
				    \ | nnoremap <silent> ]c :lua require('mini.bracketed').comment('forward', nil)<CR>
				    \ | nnoremap <silent> [c :lua require('mini.bracketed').comment('backward', nil)<CR>
				    \ | nnoremap <silent> [C :lua require('mini.bracketed').comment('first', nil)<CR>
				    \ | nnoremap <silent> ]C :lua require('mini.bracketed').comment('last', nil)<CR>
				    \ | endif
				augroup END
				" \ | :lua require('mini.bracketed').setup()
		      ]])
		end,
		event = "UIEnter",
	},
	{
		"echasnovski/mini.indentscope",
		event = "UIEnter",
		-- version = false,
		opts = {
			options = {
				indent_at_cursor = false,
			},
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
			symbol = "┃",
		},
		init = function()
			vim.cmd([[
				au FileType NvimTree,dashboard,help,lazy,lazyterm,lspinfo,man,text,mason,netrw,toggleterm,checkhealth,undotree,dbout lua vim.b.miniindentscope_disable = true
			]])
		end,
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
		-- version = false,
		event = "UIEnter",
	},
	{
		"echasnovski/mini.move",
		-- version = false,
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
		event = "BufEnter",
	},
	{ "echasnovski/mini.splitjoin", opts = {}, event = "BufEnter" },
	{ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			signs = true,
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
				NOTE = { icon = "", color = "#0AF106", alt = { "INFO" } },
				HACK = { color = "#F0FD00" },
				WARN = { color = "#FBBF24", alt = { "WARNING", "XXX" } },
				TEST = { icon = "", color = "#FF004E", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},
	{ "folke/which-key.nvim", lazy = true },
	{
		"folke/zen-mode.nvim",
		opts = { window = { width = 100 } },
		cmd = { "ZenMode" },
	},
	{ "folke/neodev.nvim", opts = {}, lazy = true },
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
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"itchyny/calendar.vim",
		cmd = { "Calendar" },
		init = function()
			vim.cmd("source ~/.config/nvim/credentials.vim")
			-- vim.g.calendar_week_number = true
			-- vim.g.calendar_date_month_name = true
			-- vim.g.calendar_task = true
			vim.g.calendar_google_calendar = true
			vim.g.calendar_google_task = true
			vim.g.calendar_date_full_month_name = true
			vim.g.calendar_event_start_time = true
			vim.g.calendar_skip_event_delete_confirm = true
			vim.g.calendar_skip_task_delete_confirm = true
			vim.g.calendar_skip_task_clear_completed_confirm = true
			vim.g.calendar_task_width = 45
			vim.g.calendar_task_delete = true
			-- vim.g.calendar_cache_directory = "~/notes/calendar.vim/"
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy", -- TODO: update to main after rewrite
		event = "LspAttach",
		opts = {
			text = { spinner = "dots" },
			window = { blend = 0 },
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {},
		event = "VeryLazy",
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
		dependencies = { "numToStr/Comment.nvim" },
	},
	{ "junkblocker/git-time-lapse", cmd = { "GitTimeLapse" } },
	{ "KabbAmine/vCoolor.vim", event = "VeryLazy" },
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
			cmd = "DB",
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{ "kristijanhusak/vim-dadbod-completion", lazy = true },
	{ "kylechui/nvim-surround", config = true, event = "BufEnter" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "InsertEnter",
		version = "v2.*",
	},
	{ "leoluz/nvim-dap-go", config = true, event = "VeryLazy", ft = "go" },
	{
		"lervag/vimtex",
		ft = "tex",
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "okular"
			vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
			vim.g.vimtex_compiler_method = "latexmk" -- default compiler
			vim.g.vimtex_format_enabled = true
			vim.g.texflavor = "latex"
			vim.cmd([[let maplocalleader = "\<space>"]])
		end,
	},
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
		"mbbill/undotree",
		cmd = {
			"UndotreeToggle",
			"UndotreeShow",
			"UndotreeToggle",
			"UndotreeHide",
			"UndotreeFocus",
			"UndotreePersistUndo",
		},
	},
	{
		"marko-cerovac/material.nvim",
		-- lazy = false,
		-- priority = 1000,
		event = "VeryLazy",
		opts = {
			lualine_style = "stealth", -- the stealth style
			async_loading = false,
			plugins = {
				"dap",
				"dashboard",
				"fidget",
				"gitsigns",
				"lspsaga",
				"mini",
				"nvim-cmp",
				"nvim-tree",
				"nvim-web-devicons",
				"telescope",
				"which-key",
			},
			disable = {
				colored_cursor = true,
				background = true,
			},
		},
		init = function()
			vim.g.material_style = "deep ocean"
		end,
	},
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", ft = "python", event = "VeryLazy" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
	},
	{ "nvim-lualine/lualine.nvim", event = "UIEnter" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			{
				"ghassan0/telescope-glyph.nvim",
				dependencies = { "nvim-telescope/telescope.nvim" },
				cmd = { "Telescope glyph" },
			},
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				cmd = { "Telescope file_browser" },
			},
			{
				"xiyaowong/telescope-emoji.nvim",
				cmd = { "Telescope emoji" },
			},
			{ "jvgrootveld/telescope-zoxide", cmd = { "Telescope zoxide list" } },
		},
	},
	{ "nvim-tree/nvim-web-devicons", config = true, lazy = true },
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		dependencies = "nvim-tree/nvim-web-devicons",
		init = function()
			vim.cmd([[
        autocmd FileType NvimTree nnoremap <buffer> <nowait> ;q <cmd>NvimTreeToggle<CR>
        autocmd FileType NvimTree nnoremap <buffer> <nowait> ;; <cmd>NvimTreeToggle<CR>
    ]])
		end,
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufEnter" },
	{ "nvimtools/none-ls.nvim", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			---@diagnostic disable: missing-fields
			require("Comment").setup({
				toggler = {
					line = "<C-_>",
				},
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"numToStr/Navigator.nvim",
		opts = {},
		cmd = {
			"NavigatorLeft",
			"NavigatorRight",
			"NavigatorUp",
			"NavigatorDown",
			"NavigatorPrevious",
		},
	},
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
	{ "onsails/lspkind.nvim", dependencies = { "hrsh7th/nvim-cmp" }, event = "InsertEnter" },
	{ "rafamadriz/friendly-snippets" },
	{ "ray-x/lsp_signature.nvim", opts = {
		hint_enable = false,
		toggle_key = "<M-x>",
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
	{
		"rhysd/clever-f.vim",
		event = "VeryLazy",
		init = function()
			-- vim.g.clever_f_ignore_case = true
			vim.g.clever_f_smart_case = true
			vim.g.clever_f_mark_char_color = 0
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			disable_background = true,
			disable_float_background = true,
		},
		event = "VeryLazy",
	},
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
	-- {"simrat39/rust-tools.nvim"},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
			keymaps = {
				["<C-s>"] = false,
				["<C-v>"] = "actions.select_vsplit",
			},
			view_options = {
				show_hidden = true,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
	},
	{
		"szw/vim-maximizer",
		cmd = { "MaximizerToggle" },
		init = function()
			vim.g.maximizer_set_default_mapping = false
		end,
	},
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },
	{ "tpope/vim-capslock", event = "VeryLazy" },
	-- { "tpope/vim-commentary", event = "VeryLazy" },
	{ "tpope/vim-dadbod", lazy = true },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-rsi", event = "InsertEnter" },
	{ "tpope/vim-sleuth", event = "BufEnter" },
	{ "tpope/vim-obsession", cmd = { "Obsession" } },
	{ "tpope/vim-speeddating", event = "VeryLazy" },
	{
		"vimwiki/vimwiki",
		event = "VeryLazy",
		init = function()
			vim.g.vimwiki_listsyms = "    X"
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_list = { { path = "~/notes/wiki/", syntax = "markdown", ext = ".md", auto_diary_index = 1 } }
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".mkd"] = "markdown", [".wiki"] = "media" }
		end,
	},
	{ "williamboman/mason.nvim", build = ":MasonUpdate", lazy = true },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "windwp/nvim-ts-autotag", event = "InsertEnter" },
	{ "windwp/nvim-autopairs", opts = { check_ts = true }, event = "InsertEnter" },
}, {
	ui = {
		border = "rounded",
	},
})

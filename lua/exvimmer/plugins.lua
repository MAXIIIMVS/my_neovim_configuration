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
				separator_style = "thin",
				diagnostics = "nvim_lsp",
			},
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		event = "VeryLazy",
		opts = {
			transparent = vim.g.is_transparent,
			styles = {
				floats = vim.g.is_transparent and "transparent" or "normal",
				sidebars = vim.g.is_transparent and "transparent" or "normal",
			},
		},
	},
	{
		"echasnovski/mini.bracketed",
		-- version = false,
		opts = {
			-- buffer = { suffix = "", options = {} },
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
		event = "UIEnter",
	},
	{
		"echasnovski/mini.move",
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
	{
		"folke/tokyonight.nvim",
		event = "VeryLazy",
		opts = {
			transparent = vim.g.is_transparent,
			styles = {
				floats = vim.g.is_transparent and "transparent" or "normal",
				sidebars = vim.g.is_transparent and "transparent" or "normal",
			},
		},
	},
	{ "folke/which-key.nvim", lazy = true },
	{
		"folke/zen-mode.nvim",
		opts = { window = { width = 100 } },
		cmd = { "ZenMode" },
	},
	{
		"ghassan0/telescope-glyph.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = { "Telescope glyph" },
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
	{ "jvgrootveld/telescope-zoxide", cmd = { "Telescope zoxide list" } },
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
		-- NOTE: install universal-ctags using apt (the snap version wasn't
		-- compatible)
		"ludovicchabant/vim-gutentags",
		event = "VeryLazy",
		init = function()
			vim.g.gutentags_generate_on_new = true
			vim.g.gutentags_generate_on_missing = true
			vim.g.gutentags_generate_on_write = true
			vim.g.gutentags_generate_on_empty_buffer = false
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
			exclude = {
				buftypes = { "terminal", "nofile" },
				filetypes = { "help", "dashboard", "NvimTree", "mason", "fugitive" },
			},
		},
	},
	{ "LunarVim/bigfile.nvim", event = "BufReadPre", opts = {} },
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
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", ft = "python", event = "VeryLazy" },
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
		init = function()
			vim.g.VM_mouse_mappings = true
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<M-n>",
				["Add Cursor Up"] = "<M-p>",
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{ "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{ "nvim-lualine/lualine.nvim", event = "UIEnter" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim", cmd = { "Telescope" } },
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = { "Telescope file_browser" },
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
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
			filetypes = { "html", "css", "sass", "javascriptreact", "typescriptreact", "scss" },
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
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },
	-- { "tpope/vim-capslock", event = "VeryLazy" },
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
			vim.g.vimwiki_listsyms = "    x"
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
	{
		"xiyaowong/telescope-emoji.nvim",
		cmd = { "Telescope emoji" },
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}, {
	ui = {
		border = "rounded",
	},
})

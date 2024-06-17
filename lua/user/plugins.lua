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
		event = "UIEnter",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			start_in_insert = true,
			persist_size = true,
			persist_mode = false,
			size = 13,
			open_mapping = [[<M-t>]],
			direction = "horizontal",
			float_opts = {
				border = "rounded",
				winblend = 0,
			},
			autochdir = false,
		},
		cmd = {
			"ToggleTerm",
			"ToggleTermSetName",
			"ToggleTermToggleAll",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
			"TermExec",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			transparent_background = vim.g.is_transparent,
			term_colors = true,
			color_overrides = {
				mocha = {
					-- base = "#1A1A2F",
					-- base = "#1D182E",
					-- base = "#171421",
					base = "#191724",
				},
			},
			highlight_overrides = {
				-- 	-- latte = telescopeBorderless("latte"),
				-- 	-- frappe = telescopeBorderless("frappe"),
				-- 	-- macchiato = telescopeBorderless("macchiato"),
				-- 	-- mocha = telescopeBorderless("mocha"),
				mocha = function()
					return {
						-- 	-- 	-- 	-- ["@text.todo"] = { fg = "#FF007A", bg = "#171421" },
						-- 	-- 	-- 	["@text.todo"] = { fg = "#FF1C7B", bg = "#171421" },
						-- 	-- 	-- 	["@text.note"] = { fg = "#0AF106", bg = "#171421" },
						-- 	-- 	-- 	["@text.warning"] = { fg = "#F0FD00", bg = "#171421" },
						["VertSplit"] = { fg = "#403d52" },
						["FloatBorder"] = { fg = "#525D8E" },
					}
				end,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				dashboard = true,
				dap = true,
				dap_ui = true,
				telescope = {
					enabled = true,
					-- style = "nvchad",
				},
				indent_blankline = {
					enabled = true,
					scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = false,
				},
				which_key = false,
				treesitter = true,
				mason = false,
				nvimtree = true,
				lsp_saga = false,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				mini = {
					enabled = true,
					indentscope_color = "lavender",
				},
				vimwiki = true,
			},
		},
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
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
		version = false,
		opts = {
			conflict = { suffix = "", options = {} },
			diagnostic = { suffix = "", options = {} },
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
		event = "InsertEnter",
	},
	{ "echasnovski/mini.bufremove", version = false, opts = { silent = true }, lazy = true },
	{
		"echasnovski/mini.jump2d",
		version = false,
		opts = {
			mappings = {
				start_jumping = ";j",
			},
			view = {
				dim = true,
				n_steps_ahead = 2,
			},
			silent = true,
		},
		keys = { ";j", { ";j", mode = "v" } },
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
				line_right = "",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},
		},
		keys = {
			{ "<C-h>", mode = { "n", "v" } },
			{ "<C-j>", mode = { "n", "v" } },
			{ "<C-k>", mode = { "n", "v" } },
		},
	},
	{
		"echasnovski/mini.splitjoin",
		version = false,
		opts = { mappings = { toggle = "gs", split = "", join = "" } },
		keys = { "gs", { "gs", mode = "v" } },
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = vim.g.is_transparent,
					terminal_colors = false,
				},
				groups = {
					all = {
						NormalFloat = { fg = "fg1", bg = "NONE" },
					},
				},
			})
		end,
	},
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
		lazy = true,
		opts = {
			transparent = vim.g.is_transparent,
			styles = {
				floats = vim.g.is_transparent and "transparent" or "normal",
				sidebars = vim.g.is_transparent and "transparent" or "normal",
			},
		},
	},
	{
		"folke/ts-comments.nvim",
		event = "InsertEnter",
		opts = {},
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{ "folke/which-key.nvim", event = "VeryLazy" },
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
				filetypes = { "help", "dashboard", "NvimTree", "mason", "fugitive", "git", "cmake" },
			},
		},
		event = "UIEnter",
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
		event = { "BufReadPost", "BufNewFile" },
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
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-telescope/telescope.nvim", cmd = { "Telescope" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{ "nvim-tree/nvim-web-devicons", config = true, lazy = true },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" } },
	{ "nvimtools/none-ls.nvim", event = "VeryLazy" },
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
	{
		"ray-x/lsp_signature.nvim",
		opts = { hint_enable = false, toggle_key = "<M-x>" },
		event = "VeryLazy",
	},
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
		dependencies = { "nvim-neotest/nvim-nio" },
	},
	{
		"rhysd/clever-f.vim",
		keys = {
			{ "f", mode = { "n", "v" } },
			{ "F", mode = { "n", "v" } },
			{ "t", mode = { "n", "v" } },
			{ "T", mode = { "n", "v" } },
		},
		init = function()
			-- vim.g.clever_f_ignore_case = true
			vim.g.clever_f_smart_case = true
			vim.g.clever_f_mark_char_color = 0
		end,
	},
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } },
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
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },
	{ "tpope/vim-dadbod", lazy = true },
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Ggrep",
			"Glgrep",
			"Gclog",
			"Gllog",
			"Gcd",
			"Glcd",
			"Gedit",
			"Gsplit",
			"Gvsplit",
			"Gtabedit",
			"Gpedit",
			"Gdrop",
			"Gread",
			"Gwrite",
			"Gwq",
			"Gdiffsplit",
			"Gvdiffsplit",
			"GMove",
			"GRename",
			"GDelete",
			"GRemove",
			"GUnlink",
			"GBrowse",
		},
	},
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-rsi", event = "InsertEnter" },
	{ "tpope/vim-sleuth", event = "BufEnter" },
	{ "tpope/vim-obsession", cmd = { "Obsession" } },
	{ "tpope/vim-speeddating", keys = { "<c-a>", "<c-x>" } },
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
		backdrop = 100,
	},
})

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
		event = "UIEnter",
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
		event = "BufRead",
		version = false,
		opts = {
			conflict = { suffix = "", options = {} },
			diagnostic = { suffix = "", options = {} },
			quickfix = { suffix = "", options = {} },
			treesitter = { suffix = "n", options = {} },
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
		      ]])
		end,
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
		opts = { mappings = { toggle = "gJ", split = "", join = "" } },
		keys = { "gJ", { "gJ", mode = "v" } },
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
		"folke/ts-comments.nvim",
		event = "InsertEnter",
		opts = {},
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"folke/which-key.nvim",
		event = "UIEnter",
		opts = {
			preset = "classic",
			win = { border = "rounded" },
		},
	},
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
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			require("cmp.utils.window").info_ = require("cmp.utils.window").info
			require("cmp.utils.window").info = function(self)
				local info = self:info_()
				info.scrollable = false
				return info
			end

			require("cmp").setup.cmdline({ "/", "?" }, {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			---@diagnostic disable-next-line: missing-fields
			require("cmp").setup.cmdline(":", {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = require("cmp").config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			require("cmp").setup({
				-- completion = {
				-- 	autocomplete = false, -- manual control
				-- },
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- 'text', 'text_symbol', 'symbol_text', 'symbol'
					}),
				},
				preselect = require("cmp").PreselectMode.None,
				window = {
					completion = {
						border = border("CmpBorder"),
						winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
						scrolloff = 0,
						side_padding = 0,
						col_offset = 0,
					},
					documentation = {
						border = border("CmpDocBorder"),
						scrolloff = 0,
						side_padding = 0,
						col_offset = 0,
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = require("cmp").mapping.preset.insert({
					["<C-u>"] = require("cmp").mapping.scroll_docs(-4),
					["<C-d>"] = require("cmp").mapping.scroll_docs(4),
					["<C-Space>"] = require("cmp").mapping.complete({}),
					["<C-c>"] = require("cmp").mapping.abort(),
					["<CR>"] = require("cmp").mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					-- ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = require("cmp").mapping(function(fallback)
						if require("cmp").visible() then
							require("cmp").select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						elseif has_words_before() then
							require("cmp").complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = require("cmp").mapping(function(fallback)
						if require("cmp").visible() then
							require("cmp").select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "calc" },
					{ name = "nvim_lsp" },
					{ name = "vim-dadbod-completion" },
					{ name = "emoji", option = { insert = false } },
					{
						name = "luasnip",
						entry_filter = function()
							return not require("cmp.config.context").in_treesitter_capture("string")
								and not require("cmp.config.context").in_syntax_group("String")
						end,
					},
					{ name = "buffer" },
					{ name = "path" },
					-- { name = "nvim_lsp_signature_help" },
					-- { name = "nvim_lua" },
				},
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
	{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
	{ "hrsh7th/cmp-path", after = "nvim-cmp" },
	{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
	{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
	{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
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
	{
		"KabbAmine/vCoolor.vim",
		cmd = {
			"VCoolor",
			"VCoolIns",
			"Rgb2Hex",
			"Rgb2RgbPerc",
			"Rgb2Hsl",
			"RgbPerc2Hex",
			"RgbPerc2Rgb",
			"Hex2Lit",
			"Hex2Rgb",
			"Hex2RgbPerc",
			"Hex2Hsl",
			"Hsl2Rgb",
			"Hsl2Hex",
			"VCase",
		},
		keys = { "<M-v>", "<M-r>", "<M-c>", "<M-w>" },
	},
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
	{ "kylechui/nvim-surround", config = true, event = "BufEnter" },
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("vimwiki", { "markdown" })
		end,
	},
	{ "leoluz/nvim-dap-go", config = true, ft = "go" },
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
		event = "BufReadPost",
	},
	{
		-- NOTE: install universal-ctags using apt (the snap version wasn't
		-- compatible)
		"ludovicchabant/vim-gutentags",
		event = "BufReadPost",
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
				filetypes = { "help", "dashboard", "NvimTree", "mason", "fugitive", "git", "cmake", "dbout" },
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
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function()
			require("dap-python").setup(
				os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			)
		end,
	},
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
		after = "mason-lspconfig.nvim",
		config = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"
			require("lspconfig").util.default_config.capabilities = vim.tbl_deep_extend(
				"force",
				require("lspconfig").util.default_config.capabilities,
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			)
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "UIEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "doom", -- hyper
			config = {
				header = {
					[[                                     ]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⢻⡾⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⢸⣼⠁⠀⠀⠄⠹⣿⣆⠀⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠐⡀⠀⠀⠸⡄⢠⡿⠀⠀⣺⣿⢾⠀⠘⣿⣧⣼⠀⠀⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠐⢄⠀⠀⠀⢳⡀⣦⣹⣥⠆⠀⠀⠀⠈⠈⢀⠀⠈⣿⣷⡎⣰⠇⠀⠀⠀⠔⠀⠀⠀⠀⠀]],
					[[⠀⠀⢀⠀⠀⠀⠈⠳⣄⢳⣼⣿⣿⠁⢀⣠⣲⣾⣿⣿⣾⣷⣦⡀⢿⣿⣴⢋⣤⠋⠀⠀⠀⢀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠉⠲⣤⡙⣶⣿⣿⡿⠀⠀⠀⠀⠀⢀⡀⢠⡠⠄⠀⠀⠀⢹⣿⣿⡞⣡⣴⠚⠁⠀⠀⠀⠀]],
					[[⠀⠈⠒⠦⣤⣈⣻⣿⣿⣿⠏⠀⢀⢴⣾⣿⣿⡿⠿⠿⠿⣿⣽⣿⠦⠀⠹⣿⣿⣾⣋⣠⡤⠖⠂⠁⠀]],
					[[⡀⠀⠀⡀⠒⠶⣾⣿⣿⠃⢀⣤⠟⠉⠀⠀⣠⣤⠀⠀⠀⠀⠀⠀⠀⠑⠀⠘⣿⢿⡶⠖⢀⠀⠀⠀⡀]],
					[[⠀⠀⠀⠤⠤⣤⣿⡿⠀⠐⠀⢠⣶⡄⡀⣆⠸⠿⠀⠀⠀⢰⣸⡇⣾⣆⠀⠀⠀⣿⣷⣤⠤⠄⠀⠀⠀]],
					[[⠒⠂⠉⠉⢹⣿⡟⢀⠤⠀⣼⣿⣿⣿⣆⠻⣯⣶⡶⠶⣿⡽⢋⣾⣿⡿⢀⣴⠇⠀⠿⢿⡉⠉⠉⠐⠂]],
					[[⠀⠀⣀⣴⣿⠏⠀⠀⢤⣛⣶⣤⣍⣿⣿⣿⣿⣶⣶⣶⣾⣿⣿⣷⣿⣋⣴⣨⣖⡀⠀⠀⠸⣄⡀⠀⠀]],
					[[⠀⢀⣾⢿⠃⠀⠀⠀⠼⡿⣷⣼⣧⣾⣦⢿⣿⣭⣭⣭⡴⠖⣻⣿⠶⢟⣉⣭⣶⠢⠄⠀⠀⠈⣦⠀⠀]],
					[[⣠⠿⠟⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⡀⣷⠀]],
					[[⠀⠀⠈⠈⢈⠜⠉⠉⠉⣸⠋⣼⢡⡟⣿⣿⢿⣿⣿⣿⣿⡿⡟⣿⠹⡌⢻⡀⠁⠀⠙⢄⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⢀⠊⠀⠀⢠⠏⠰⠀⡿⢸⠀⡇⢸⠈⣇⠸⠀⢷⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠃⠀⠀⢰⠀⠀⠀⡇⠀⠀⢸⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠂⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					[[             MEMENTO MORI            ]],
					[[            MEMENTO VIVERE           ]],
					[[                                     ]],
				},
				center = {
					{
						icon = "🗓 ",
						desc = "Calendar",
						action = "Calendar",
						key = "c",
					},
					{
						icon = "📓 ",
						desc = "Open Wiki",
						action = "VimwikiIndex",
						key = "w",
					},
					{
						icon = "💻 ",
						desc = "Terminal",
						action = "ToggleTerm",
						key = "t",
					},
					{
						icon = "🚀 ",
						desc = "Manage LSP/Formatters/...                    ",
						action = "Mason",
						key = "m",
					},
					{
						icon = "🔌 ",
						desc = "Extensions",
						action = "Lazy",
						key = "x",
					},
					{
						icon = "🚪 ",
						desc = "Quit",
						action = "q",
						key = "q",
					},
				},
				footer = {
					"👑 " .. "Control Of Consciousness Determines The Quality Of Life" .. " 👑",
				},
			},
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("lspsaga").setup({
				hover = {
					max_width = 0.7,
				},
				preview = {
					lines_above = 0,
					lines_below = 0,
				},
				scroll_preview = {
					scroll_down = "<C-d>",
					scroll_up = "<C-u>",
				},
				ui = {
					theme = "round",
					border = "rounded",
					winblend = 0,
					colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				},
				lightbulb = {
					enable = false,
					virtual_text = false,
					-- debounce = 0,
				},
				outline = {
					win_width = 40,
				},
				symbol_in_winbar = {
					enable = true, -- don't toggle
					hide_keyword = false,
					folder_level = 3,
					color_mode = true,
					delay = 0,
				},
				beacon = {
					enable = false,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		config = function()
			local custom_auto = require("lualine.themes.auto")
			custom_auto.normal.c.bg = "NONE"
			-- custom_auto.insert.c.bg = "NONE"
			-- custom_auto.terminal.c.bg = "NONE"
			-- custom_auto.visual.c.bg = "NONE"
			-- custom_auto.command.c.bg = "NONE"
			-- custom_auto.replace.c.bg = "NONE"
			-- stylua: ignore
			local colors = {
				bg       = '#202328',
				fg       = '#bbc2cf',
				yellow   = '#ECBE7B',
				cyan     = '#008080',
				darkblue = '#081633',
				green    = '#98be65',
				orange   = '#FF8800',
				violet   = '#a9a1e1',
				magenta  = '#c678dd',
				blue     = '#51afef',
				red      = '#ec5f67',
				tmux     = '#E9AD0C',
			}
			local mode_color = {
				n = colors.tmux,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			local function show_macro_recording()
				local recording_register = vim.fn.reg_recording()
				if recording_register == "" then
					return ""
				else
					return "Recording @" .. recording_register
				end
			end

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 85
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
				search_available = function()
					local search_count = vim.fn.searchcount()
					return (search_count and search_count.total or 0) > 0
				end,
				is_not_terminal = function()
					return vim.bo.buftype ~= "terminal"
				end,
			}

			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					-- theme = "catppuccin",
					-- theme = "auto", -- remove custom_auto
					theme = custom_auto,
					-- theme = {
					-- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
					-- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
					-- },
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x or right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = function()
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { left = 0, right = 1 }, -- We don't need space before this
			})

			ins_left({
				"mode",
				color = function()
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({
				"filetype",
				icon_only = true,
				-- icon = { align = "left" },
				cond = conditions.is_not_terminal,
			})

			ins_left({
				"filename",
				cond = conditions.is_not_terminal,
				color = { fg = colors.magenta, gui = "bold" },
				path = 4,
			})

			ins_left({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})

			ins_left({
				"diff",
				symbols = { added = " ", modified = "柳", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			-- ins_left({
			-- 	function()
			-- 		return "%="
			-- 	end,
			-- })

			ins_right({
				"selectioncount",
				color = { fg = colors.orange },
			})

			ins_right({
				"searchcount",
				cond = conditions.search_available,
				color = { fg = colors.orange },
			})

			ins_right({
				function()
					if vim.o.cmdheight == 0 then
						return show_macro_recording()
					else
						return ""
					end
				end,
				color = { fg = colors.orange },
			})

			-- ins_right({
			-- 	function()
			-- 		if #vim.api.nvim_list_wins() > 1 then
			-- 			return "[" .. vim.api.nvim_win_get_number(0) .. "]"
			-- 		else
			-- 			return ""
			-- 		end
			-- 	end,
			-- 	color = { fg = colors.orange },
			-- })

			ins_right({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			ins_right({
				function()
					local msg = ""
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end

					local uniqueNames = {}
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							if not uniqueNames[client.name] then
								uniqueNames[client.name] = true
								if msg ~= "" then
									msg = msg .. ", "
								end
								msg = msg .. client.name
							end
						end
					end

					return msg
				end,
				color = { fg = colors.violet, gui = "bold" },
				cond = conditions.hide_in_width,
			})

			ins_right({
				"filesize",
				fmt = string.upper,
				cond = function()
					return conditions.buffer_not_empty() and conditions.hide_in_width()
				end,
			})

			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = "bold" },
				cond = conditions.hide_in_width,
			})

			ins_right({ "progress", color = { fg = colors.cyan, gui = "bold" } })

			ins_right({ "location", color = { fg = colors.cyan, gui = "bold" } })

			ins_right({
				function()
					return "▊"
				end,
				color = function()
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { left = 1 },
			})
			require("lualine").setup(config)
		end,
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-telescope/telescope.nvim", cmd = { "Telescope" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{ "nvim-tree/nvim-web-devicons", config = true, event = "UIEnter" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				incremental_selection = { enable = true },
				textobjects = { enable = true },
				ensure_installed = {
					"asm",
					"astro",
					"bash",
					"c",
					"c_sharp",
					"cmake",
					"cpp",
					"css",
					"csv",
					"diff",
					"dockerfile",
					"embedded_template",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gotmpl",
					"gowork",
					"graphql",
					"html",
					"htmldjango",
					"http",
					"ini",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"llvm",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"mermaid",
					"ninja",
					"php",
					"prisma",
					"proto",
					"pug",
					"python",
					"regex",
					"requirements",
					"ruby",
					"rust",
					"scss",
					"solidity",
					"sql",
					"svelte",
					"templ",
					"tmux",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
					-- "latex",
				},
				sync_install = false,
				indent = {
					enable = true,
				},
				highlight = {
					additional_vim_regex_highlighting = false,
					enable = true,
				},
				autotag = {
					enable = true,
				},
			})
		end,
	},
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
			filetypes = { "*", "!vimwiki" },
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
		event = "BufReadPre",
	},
	{ "onsails/lspkind.nvim", dependencies = { "hrsh7th/nvim-cmp" }, event = "InsertEnter" },
	{ "rafamadriz/friendly-snippets", event = "InsertEnter" },
	{ "ray-x/lsp_signature.nvim", event = "LspAttach" },
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
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
	{
		"rolv-apneseth/tfm.nvim",
		lazy = true,
		opts = {
			enable_cmds = true,
			keybindings = {
				["<ESC>"] = "q",
				["<C-v>"] = "<C-\\><C-o> <cmd>lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>|<CR>",
				["<C-s>"] = "<C-\\><C-o> <cmd>lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>|<CR>",
				["<C-t>"] = "<C-\\><C-o> <cmd>lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR>|<CR>",
			},
		},
	},
	{ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
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
	{ "tpope/vim-abolish", event = "BufRead" },
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
	{ "tpope/vim-sleuth", event = { "BufNewFile", "BufReadPost", "BufFilePost" } },
	{ "tpope/vim-obsession", cmd = { "Obsession" } },
	{ "tpope/vim-speeddating", keys = { "<c-a>", "<c-x>" } },
	{
		"vimwiki/vimwiki",
		cmd = {
			"VimwikiIndex",
			"VimwikiVar",
			"VimwikiTabIndex",
			"VimwikiUISelect",
			"VimwikiDiaryIndex",
			"VimwikiShowVersion",
			"VimwikiMakeDiaryNote",
			"VimwikiTabMakeDiaryNote",
			"VimwikiDiaryGenerateLinks",
			"VimwikiMakeTomorrowDiaryNote",
			"VimwikiMakeYesterdayDiaryNote",
		},
		keys = { "<leader>w" },
		ft = { "vimwiki", "vimwiki_markdown_custom" },
		init = function()
			vim.g.vimwiki_listsyms = "    x"
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_list = { { path = "~/notes/wiki/", syntax = "markdown", ext = ".md", auto_diary_index = 1 } }
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".mkd"] = "markdown", [".wiki"] = "media" }
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate", "MasonUninstallAll" },
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					check_outdated_packages_on_open = true,
				},
				max_concurrent_installers = 1,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		after = "mason.nvim",
		config = function()
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- if vim.lsp.inlay_hint then
				-- 	vim.lsp.inlay_hint.enable(true)
				-- end

				require("lsp_signature").on_attach({
					hint_enable = false,
					bind = true,
					handler_opts = {
						border = "rounded",
					},
				}, bufnr)

				if
					client.name == "clangd"
					or client.name == "prismals"
					or client.name == "neocmake"
					or client.name == "rust_analyzer"
					or client.name == "eslint_d"
					or client.name == "texlab" -- doesn't work
				then
					vim.api.nvim_command([[augroup Format]])
					vim.api.nvim_command([[autocmd! * <buffer>]])
					vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
					vim.api.nvim_command([[augroup END]])
				end
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
					})
				end,
				-- Next, you can provide targeted overrides for specific servers.
				["cssls"] = function()
					require("lspconfig").util.default_config.capabilities.textDocument.completion.completionItem.snippetSupport =
						true
					require("lspconfig").cssls.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
					})
				end,
				["emmet_ls"] = function()
					require("lspconfig").emmet_ls.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						filetypes = {
							"html",
							"css",
							"sass",
							"scss",
							"less",
							"vue",
							"javascriptreact",
							"typescriptreact",
							"jsx",
							"tsx",
							"htmldjango", -- doesn't work
							"gohtml",
							"tmpl.html",
							"template",
						},
					})
				end,
				["html"] = function()
					require("lspconfig").util.default_config.capabilities.textDocument.completion.completionItem.snippetSupport =
						true
					require("lspconfig").html.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						filetypes = {
							"html",
							"handlebars",
							"htmldjango",
							"blade",
							"gohtml",
							"tmpl.html",
							"template",
						},
					})
				end,
				["jsonls"] = function()
					require("lspconfig").util.default_config.capabilities.textDocument.completion.completionItem.snippetSupport =
						true
					require("lspconfig").jsonls.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
					})
				end,
				["tsserver"] = function()
					require("lspconfig").tsserver.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						filetypes = {
							"javascript",
							"typescript",
							"javascriptreact",
							"typescriptreact",
							"jsx",
							"tsx",
						},
					})
				end,
				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						settings = {
							["rust-analyzer"] = {
								assist = {
									importGranularity = "module",
									importPrefix = "self",
								},
								cargo = {
									loadOutDirsFromCheck = true,
								},
								procMacro = {
									enable = true,
								},
								checkOnSave = {
									command = "clippy",
								},
							},
						},
					})
					-- require("rust-tools").setup {}
				end,
				["pyright"] = function()
					require("lspconfig").pyright.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						settings = {
							python = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "workspace",
									useLibraryCodeForTypes = true,
								},
							},
						},
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						on_attach = on_attach,
						capabilities = require("lspconfig").util.default_config.capabilities,
						cmd = { "gopls", "serve" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
						settings = {
							gopls = {
								templateExtensions = { "tpl", "yaml", "tmpl", "tmpl.html" },
								experimentalPostfixCompletions = true,
								gofumpt = true,
								usePlaceholders = true,
								analyses = {
									shadow = true,
									nilness = true,
									unusedresult = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
									unreachable = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								staticcheck = true,
							},
						},
					})
				end,
			})
			require("mason-lspconfig").setup()
		end,
	},
	{ "windwp/nvim-ts-autotag", event = "InsertEnter" },
	{
		"windwp/nvim-autopairs",
		opts = { check_ts = true },
		config = function()
			require("cmp").event:on(
				"confirm_done",
				require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
			)
		end,
		event = "InsertEnter",
	},
}, {
	ui = {
		border = "rounded",
		backdrop = 100,
	},
})

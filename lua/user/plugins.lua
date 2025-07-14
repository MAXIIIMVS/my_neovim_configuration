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
	-- ────────────────────────────────── A ──────────────────────────────────
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
		event = { "BufNewFile", "BufReadPre" },
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				themable = true,
				offsets = {
					{
						filetype = "dbui",
						text = "DB",
						highlight = "Directory",
						separator = true,
					},
					{
						filetype = "netrw",
						text = "Netrw",
						highlight = "Directory",
						separator = true,
					},
					{
						filetype = "undotree",
						text = "Undo Tree",
						highlight = "Directory",
						separator = true,
					},
					{
						filetype = "sagaoutline",
						text = "Lspsaga Outline",
						highlight = "Directory",
						separator = false,
					},
				},
				sort_by = "insert_at_end",
				numbers = "none",
				separator_style = "thin",
				diagnostics = "nvim_lsp",
			},
		},
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
	-- ────────────────────────────────── B ──────────────────────────────────
	-- ────────────────────────────────── C ──────────────────────────────────
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
			dim_inactive = {
				enabled = false,
				percentage = 0.01,
			},
			color_overrides = {
				-- #1A1A2F #1D182E #171421, terminal background: #171421
				-- mocha = { base = "#191724" },
				mocha = { base = "#1A1527" },
			},
			highlight_overrides = {
				all = function(colors)
					return {
						WinSeparator = { fg = "#554D80" },
						NetrwTreeBar = { fg = colors.peach },
						FloatBorder = { fg = "#6C70B8" },
					}
				end,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				dadbod_ui = false,
				dap = true,
				dap_ui = true,
				which_key = false,
				treesitter = true,
				mason = false,
				nvimtree = true,
				noice = false,
				lsp_saga = false,
				markdown = true,
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
					inlay_hints = { background = true },
				},
				mini = {
					enabled = true,
					indentscope_color = "lavender",
				},
				snacks = {
					enabled = true,
					indent_scope_color = "lavender",
				},
				vimwiki = false,
			},
		},
	},
	-- { "chentoast/marks.nvim", event = "BufReadPre", opts = {} },
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
	-- ────────────────────────────────── D ──────────────────────────────────
	{ "dmitmel/cmp-digraphs", event = "InsertEnter", dependencies = "hrsh7th/nvim-cmp" },
	-- ────────────────────────────────── E ──────────────────────────────────
	{
		"echasnovski/mini.jump2d",
		version = false,
		opts = {
			mappings = { start_jumping = ";j" },
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
				right = "<c-l>",
				down = "<C-j>",
				up = "<C-k>",
				line_left = "<C-h>",
				line_right = "<c-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},
		},
		keys = {
			{ "<C-h>", mode = { "n", "v" } },
			{ "<C-j>", mode = { "n", "v" } },
			{ "<C-k>", mode = { "n", "v" } },
			{ "<C-l>", mode = { "n", "v" } },
		},
	},
	{
		"echasnovski/mini.splitjoin",
		version = false,
		opts = { mappings = { toggle = "gJ", split = "", join = "" } },
		keys = { "gJ", mode = { "n", "v" } },
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
				groups = { all = { NormalFloat = { fg = "fg1", bg = "NONE" } } },
			})
		end,
	},
	-- ────────────────────────────────── F ──────────────────────────────────
	{
		"folke/noice.nvim",
		event = "CmdlineEnter",
		cmd = { "Noice", "NoiceEnable", "NoiceDisable" },
		init = function()
			vim.g.noice_enabled = true
		end,
		opts = {
			messages = { view_search = false },
			lsp = {
				hover = { enabled = false },
				signature = { enabled = false },
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { size = 1 * 1024 * 1024 },
			bufdelete = { enabled = true },
			gitbrowse = {
				enabled = true,
				what = "file", -- what to open. not all remotes support all types
			},
			indent = {
				enabled = true,
				animate = { enabled = false },
			},
			notifier = { enabled = true },
			quickfile = { enabled = true },
			picker = {
				enabled = true,
				layout = {
					preset = function()
						return vim.o.columns <= 130 and "vertical" or "telescope"
					end,
				},
				-- sources = { explorer = { auto_close = true } },
				layouts = {
					telescope = { -- override telescope layout, swap input and list place
						reverse = false,
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.8,
							height = 0.9,
							border = "none",
							{
								box = "vertical",
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.5,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
				},
				formatters = { file = { truncate = 120 } },
				win = {
					input = {
						keys = {
							["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
							["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
						},
					},
				},
			},
			dashboard = {
				enabled = true,
				preset = {
					header = [[

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⢻⡾⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⢸⣼⠁⠀⠀⠄⠹⣿⣆⠀⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠐⡀⠀⠀⠸⡄⢠⡿⠀⠀⣺⣿⢾⠀⠘⣿⣧⣼⠀⠀⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠐⢄⠀⠀⠀⢳⡀⣦⣹⣥⠆⠀⠀⠀⠈⠈⢀⠀⠈⣿⣷⡎⣰⠇⠀⠀⠀⠔⠀⠀⠀⠀⠀
⠀⠀⢀⠀⠀⠀⠈⠳⣄⢳⣼⣿⣿⠁⢀⣠⣲⣾⣿⣿⣾⣷⣦⡀⢿⣿⣴⢋⣤⠋⠀⠀⠀⢀⠀⠀⠀
⠀⠀⠀⠀⠉⠲⣤⡙⣶⣿⣿⡿⠀⠀⠀⠀⠀⢀⡀⢠⡠⠄⠀⠀⠀⢹⣿⣿⡞⣡⣴⠚⠁⠀⠀⠀⠀
⠀⠈⠒⠦⣤⣈⣻⣿⣿⣿⠏⠀⢀⢴⣾⣿⣿⡿⠿⠿⠿⣿⣽⣿⠦⠀⠹⣿⣿⣾⣋⣠⡤⠖⠂⠁⠀
⡀⠀⠀⡀⠒⠶⣾⣿⣿⠃⢀⣤⠟⠉⠀⠀⣠⣤⠀⠀⠀⠀⠀⠀⠀⠑⠀⠘⣿⢿⡶⠖⢀⠀⠀⠀⡀
⠀⠀⠀⠤⠤⣤⣿⡿⠀⠐⠀⢠⣶⡄⡀⣆⠸⠿⠀⠀⠀⢰⣸⡇⣾⣆⠀⠀⠀⣿⣷⣤⠤⠄⠀⠀⠀
⠒⠂⠉⠉⢹⣿⡟⢀⠤⠀⣼⣿⣿⣿⣆⠻⣯⣶⡶⠶⣿⡽⢋⣾⣿⡿⢀⣴⠇⠀⠿⢿⡉⠉⠉⠐⠂
⠀⠀⣀⣴⣿⠏⠀⠀⢤⣛⣶⣤⣍⣿⣿⣿⣿⣶⣶⣶⣾⣿⣿⣷⣿⣋⣴⣨⣖⡀⠀⠀⠸⣄⡀⠀⠀
⠀⢀⣾⢿⠃⠀⠀⠀⠼⡿⣷⣼⣧⣾⣦⢿⣿⣭⣭⣭⡴⠖⣻⣿⠶⢟⣉⣭⣶⠢⠄⠀⠀⠈⣦⠀⠀
⣠⠿⠟⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⡀⣷⠀
⠀⠀⠈⠈⢈⠜⠉⠉⠉⣸⠋⣼⢡⡟⣿⣿⢿⣿⣿⣿⣿⡿⡟⣿⠹⡌⢻⡀⠁⠀⠙⢄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⠊⠀⠀⢠⠏⠰⠀⡿⢸⠀⡇⢸⠈⣇⠸⠀⢷⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠃⠀⠀⢰⠀⠀⠀⡇⠀⠀⢸⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠂⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
MEMENTO MORI
MEMENTO VIVERE]],
					keys = {
						{
							icon = " ",
							desc = "Calendar",
							action = ":Calendar",
							key = "c",
						},
						{
							icon = "󰖬 ",
							desc = "Open Wiki",
							action = ":VimwikiIndex",
							key = "w",
						},
						{
							icon = "󰉉 ",
							desc = "Restore Session",
							action = function()
								local session_file = vim.fn.getcwd() .. "/Session.vim"
								if vim.fn.filereadable(session_file) == 1 then
									vim.cmd("silent! source Session.vim")
								else
									vim.notify("No session file found for this project.", vim.log.levels.WARN)
								end
							end,
							key = "s",
						},
						{
							icon = "󱁤 ",
							desc = "Manage LSP/Formatters/...                    ",
							action = ":Mason",
							key = "m",
						},
						{
							icon = " ",
							desc = "Extensions",
							action = ":Lazy",
							key = "x",
						},
						{
							icon = "󰒓 ",
							desc = "Neovim Config Files",
							key = "v",
							action = ":lua Snacks.picker.files({ cwd = '~/.config/nvim' })",
						},
						{ icon = "󰈆 ", key = "q", desc = "Quit", action = ":qa" },
						{
							align = "center",
							text = "󰆥 " .. "Time Without Purpose Is a Prison" .. " 󰆥",
						},
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					-- { section = "startup" },
				},
			},
			zen = {
				enabled = true,
				toggles = { dim = false },
				show = {
					statusline = true,
					-- tabline = true,
				},
			},
			styles = {
				zen = {
					backdrop = {
						transparent = true,
						blend = 0,
						-- bg = "#171421",
						-- bg = "#1B1725",
						win = {
							-- NOTE: you can use TabLineFill instead of BufferlineBackground
							wo = { winhighlight = "Normal:BufferlineBackground" },
						},
					},
				},
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		event = "BufReadPost",
		cmd = { "TodoTelescope" },
		opts = {
			signs = false,
			highlight = {
				multiline = false,
				multiline_context = 0,
				keyword = "fg",
				before = "",
				after = "",
			},
		},
	},
	-- { "folke/trouble.nvim", opts = {}, cmd = "Trouble" },
	{
		"folke/ts-comments.nvim",
		event = "InsertEnter",
		opts = {},
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		opts = {
			preset = "classic",
			win = { border = "rounded" },
		},
	},
	-- ────────────────────────────────── G ──────────────────────────────────
	{ "godlygeek/tabular", cmd = "Tabularize" },
	-- { "github/copilot.vim" },
	-- ────────────────────────────────── H ──────────────────────────────────
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			}

			-- NOTE: if you want to change the popup width, do this
			-- max_width = 50 -- you can set this in window.completion
			-- MAX_ABBR_WIDTH = 30
			-- MAX_MENU_WIDTH = 18

			-- Controls how wide the actual suggestion name (like strftime_l~) can be before truncating it.
			local MAX_ABBR_WIDTH = 35
			-- Controls the right-side column, like function signatures or [LSP].
			local MAX_MENU_WIDTH = 23

			local function format(entry, vim_item)
				if vim.api.nvim_get_mode().mode == "c" then
					return vim_item -- don't format in cmdline mode
				end
				local icon = kind_icons[vim_item.kind] or ""
				-- local abbr = vim_item.abbr
				-- local menu = vim_item.menu or ""
				-- if string.len(abbr) > MAX_ABBR_WIDTH then
				-- 	abbr = string.sub(abbr, 1, MAX_ABBR_WIDTH - 1) .. "…"
				-- end
				-- if string.len(menu) > MAX_MENU_WIDTH then
				-- 	menu = string.sub(menu, 1, MAX_MENU_WIDTH - 1) .. "…"
				-- end
				-- vim_item.abbr = icon .. " " .. abbr .. " "
				vim_item.abbr = icon .. " " .. vim_item.abbr .. " "
				vim_item.kind = ""
				-- vim_item.menu = menu
				vim_item.menu = ""
				return vim_item
			end

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				-- mapping = require("cmp").mapping.preset.cmdline(),
				mapping = cmp.mapping.preset.cmdline({
					["<Tab>"] = {
						c = function(_)
							if cmp.visible() then
								if #cmp.get_entries() == 1 then
									cmp.confirm({ select = true })
								else
									cmp.select_next_item()
								end
							else
								cmp.complete()
								if #cmp.get_entries() == 1 then
									cmp.confirm({ select = true })
								end
							end
						end,
					},
					["<S-Tab>"] = {
						c = function(_)
							if cmp.visible() then
								if #cmp.get_entries() == 1 then
									cmp.confirm({ select = true })
								else
									cmp.select_prev_item()
								end
							else
								cmp.complete()
								if #cmp.get_entries() == 1 then
									cmp.confirm({ select = true })
								end
							end
						end,
					},
				}),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			cmp.setup({
				formatting = { format = format },
				preselect = cmp.PreselectMode.None,
				-- completion = {
				-- 	autocomplete = false,
				-- },
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered({
						max_width = 60,
						max_height = 10,
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-c>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						elseif has_words_before() then
							cmp.complete()
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				performance = {
					debounce = 0,
					throttle = 0,
				},
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "vim-dadbod-completion" },
					{
						name = "luasnip",
						entry_filter = function()
							return not require("cmp.config.context").in_treesitter_capture("string")
								and not require("cmp.config.context").in_syntax_group("String")
						end,
					},
					{ name = "emoji", option = { insert = false } },
					{ name = "buffer" },
					{ name = "digraphs" },
				}, {
					{ name = "calc" },
					-- { name = "nvim_lua" },
				}),
			})
		end,
	},
	{ "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdlineEnter" }, dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-calc", event = { "InsertEnter" }, dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-cmdline", event = { "CmdlineEnter", "InsertEnter" }, dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-emoji", event = { "InsertEnter" }, dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp", event = "LspAttach", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-path", event = { "InsertEnter", "CmdlineEnter" }, dependencies = "hrsh7th/nvim-cmp" },
	-- ────────────────────────────────── I ──────────────────────────────────
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
	-- ────────────────────────────────── J ──────────────────────────────────
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	event = "LspAttach",
	-- 	opts = {
	-- 		notification = {
	-- 			window = {
	-- 				winblend = 0,
	-- 				-- border = "rounded",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{ "junkblocker/git-time-lapse", cmd = { "GitTimeLapse" } },
	-- ────────────────────────────────── K ──────────────────────────────────
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
		keys = { "<M-v>", "<M-r>", "<M-c>", "<M-w>", mode = { "n", "i", "x" } },
	},
	-- { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
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
	{
		"kylechui/nvim-surround",
		config = true,
		keys = {
			"ys",
			"yss",
			"yS",
			"ySS",
			"ds",
			"cs",
			"cS",
			{ "S", mode = { "n", "v" } },
			{ "gS", mode = { "n", "v" } },
			{ "<C-g>s", mode = { "i" } },
			{ "<C-g>S", mode = { "i" } },
		},
	},
	-- ────────────────────────────────── L ──────────────────────────────────
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = { "BufNewFile", "BufReadPost", "BufFilePost" },
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("vimwiki", { "markdown" })
			require("luasnip").filetype_extend("scratch", { "markdown" })
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
	{ "LudoPinelli/comment-box.nvim", lazy = true, cmd = "CB" },
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
	-- ────────────────────────────────── M ──────────────────────────────────
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
		"mfussenegger/nvim-dap",
		lazy = true,
		cmd = { "Dap" },
		keys = { "<space>d" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("dapui")
			require("nvim-dap-virtual-text")
			require("dap").listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end

			require("dap").listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close()
			end

			require("dap").listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close()
			end

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

			-- Setup nvim-dap virtual text
			require("dap").listeners.after["event_initialized"]["dap-virtual-text"] = function()
				vim.fn.sign_define(
					"DapVirtualTextError",
					{ text = " ", texthl = "DiagnosticVirtualTextError", linehl = "", numhl = "" }
				)
				vim.fn.sign_define(
					"DapVirtualTextWarning",
					{ text = " ", texthl = "DiagnosticVirtualTextWarning", linehl = "", numhl = "" }
				)
			end

			-- Load nvim-dap configuration for C/C++
			require("dap").adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode-14", -- adjust as needed, must be absolute path
				name = "lldb",
			}

			require("dap").configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					console = "integratedTerminal",
					program = function()
						local p = vim.fn.expand("%:p:h")
						---@diagnostic disable-next-line: redundant-parameter
						-- return vim.fn.input("Path to executable: ", p .. "/", "file")
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
				{
					-- NOTE: If you get an "Operation not permitted" error using this, try disabling YAMA:
					--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--  set it to 1 after you finished
					name = "Attach to process",
					type = "lldb",
					request = "attach",
					console = "integratedTerminal",
					pid = require("dap.utils").pick_process,
					args = {},
				},
			}
			require("dap").configurations.c = require("dap").configurations.cpp
			require("dap").configurations.rust = require("dap").configurations.cpp

			-- Load nvim-dap configuration for Go
			require("dap").adapters.go = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/go/bin/dlv" },
			}
			-- use dap-go, or you can provide your own configurations

			-- TODO: copy configs from lazy vim site.
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						os.getenv("HOME")
							.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			local exts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			}

			for _, ext in ipairs(exts) do
				require("dap").configurations[ext] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						runtimeExecutable = "deno",
						runtimeArgs = {
							"run",
							"--inspect-wait",
							"--allow-all",
						},
						program = "${file}",
						cwd = "${workspaceFolder}",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						runtimeExecutable = "node",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with ts-node)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "--loader", "ts-node/esm" },
						runtimeExecutable = "node",
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with jest)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
						runtimeExecutable = "node",
						args = { "${file}", "--coverage", "false" },
						rootPath = "${workspaceFolder}",
						sourceMaps = true,
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with vitest)",
						cwd = vim.fn.getcwd(),
						program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
						args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
						autoAttachChildProcesses = true,
						smartStep = true,
						console = "integratedTerminal",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach Program (pwa-chrome)",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						port = function()
							return tonumber(vim.fn.input("PORT: "))
						end,
						webRoot = "${workspaceFolder}",
					},
					{
						type = "node2",
						request = "attach",
						name = "Attach Program (Node2)",
						processId = require("dap.utils").pick_process,
					},
					{
						type = "node2",
						request = "attach",
						name = "Attach Program (Node2 with ts-node)",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
						port = 9229,
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach Program (pwa-node)",
						cwd = vim.fn.getcwd(),
						-- cwd = "$workspaceFolder",
						processId = require("dap.utils").pick_process,
						skipFiles = { "<node_internals>/**" },
						sourceMaps = true,
					},
				}
			end
		end,
	},
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
		lazy = true,
		keys = { "<M-n>", "<M-p>", "<S-RIGHT>", "<S-LEFT>", { "<C-n>", "<C-p>", mode = { "n", "v" } } },
		init = function()
			vim.g.VM_mouse_mappings = true
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<M-n>",
				["Add Cursor Up"] = "<M-p>",
			}
		end,
	},
	-- ────────────────────────────────── N ──────────────────────────────────
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
					enable = false, -- don't toggle
					hide_keyword = false,
					folder_level = 3,
					color_mode = true,
					delay = 0,
				},
				beacon = { enable = false },
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"tpope/vim-obsession",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local custom_auto = require("lualine.themes.auto")
			custom_auto.normal.c.bg = "NONE"
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
					return vim.fn.winwidth(0) > vim.g.big_screen_size
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
				cond = function()
					return conditions.is_not_terminal() and conditions.hide_in_width()
				end,
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
				-- cond = conditions.hide_in_width,
			})

			ins_left({
				"diff",
				symbols = { added = " ", modified = "柳", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				-- cond = conditions.hide_in_width,
			})

			ins_left({
				function()
					return vim.fn.ObsessionStatus("▶", "Ⅱ")
				end,
				color = { fg = colors.green },
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
					local clients = vim.lsp.get_clients()
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
				color = { fg = colors.violet },
				-- cond = conditions.hide_in_width,
			})

			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = "bold" },
				cond = conditions.hide_in_width,
			})

			ins_right({
				"filesize",
				fmt = string.upper,
				cond = function()
					return conditions.buffer_not_empty() and conditions.hide_in_width()
				end,
				color = { fg = colors.cyan },
			})

			ins_right({
				function()
					return vim.api.nvim_buf_line_count(0)
				end,
				color = { fg = colors.cyan, gui = "bold" },
				cond = conditions.hide_in_width,
			})

			ins_right({
				"progress",
				color = { fg = colors.cyan },
				cond = conditions.hide_in_width,
			})

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
	{ "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		branch = "master",
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
				indent = { enable = true },
				highlight = {
					additional_vim_regex_highlighting = false,
					enable = true,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufNewFile", "BufReadPost", "BufFilePost" },
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			require("null-ls").setup({
				sources = {
					-- require("null-ls").builtins.formatting.asmfmt,
					-- require("null-ls").builtins.formatting.clang_format.with({
					-- 	filetypes = { "asm" },
					-- 	args = { "-style=llvm" },
					-- }),
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.black,
					require("null-ls").builtins.formatting.djhtml,
					require("null-ls").builtins.formatting.shfmt,
					require("null-ls").builtins.formatting.csharpier,
					-- require("null-ls").builtins.formatting.djlint,
					-- require("null-ls").builtins.formatting.gofmt,
					require("null-ls").builtins.formatting.prettierd.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"css",
							"scss",
							"less",
							"html",
							"json",
							"jsonc",
							"yaml",
							"markdown",
							"markdown.mdx",
							"vimwiki",
							"graphql",
							"template",
							"handlebars",
							"xml",
						},
						extra_args = function(params)
							if params.ft == "xml" then
								return { "--parser", "xml" }
							end
						end,
						condition = function()
							return vim.fn.executable("prettierd") > 0
						end,
					}),
				},
				on_attach = function(client, bufnr)
					if client:supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								lsp_formatting(bufnr)
							end,
						})
					end
				end,
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
		ft = { "css", "html", "htmx", "scss", "javascriptreact", "typescriptreact" },
		cmd = "ColorizerToggle",
		opts = {
			filetypes = { "*", "!toggleterm", "!vimwiki" },
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
	},
	-- ────────────────────────────────── O ──────────────────────────────────
	-- ────────────────────────────────── P ──────────────────────────────────
	-- ────────────────────────────────── Q ──────────────────────────────────
	-- ────────────────────────────────── R ──────────────────────────────────
	{ "rafamadriz/friendly-snippets", event = { "BufNewFile", "BufReadPost", "BufFilePost" } },
	{ "ray-x/lsp_signature.nvim", event = "LspAttach" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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
		lazy = true,
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
	{ "romainl/vim-cool", event = { "CmdlineEnter" }, keys = { "#", "*", "n", "N" } },
	-- ────────────────────────────────── S ──────────────────────────────────
	{
		"saadparwaiz1/cmp_luasnip",
		event = { "BufNewFile", "BufReadPost", "BufFilePost" },
		dependencies = { "nvim-cmp", "LuaSnip" },
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		opts = {
			default_file_explorer = false,
			keymaps = {
				["<C-s>"] = false,
				["<C-v>"] = "actions.select_vsplit",
			},
			view_options = { show_hidden = true },
		},
	},
	-- ────────────────────────────────── T ──────────────────────────────────
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		config = function()
			require("nvim-dap-virtual-text").setup({
				highlight = "DiagnosticVirtualTextError",
				prefix = " ",
				spacing = 2,
				severity_limit = "error",
				virtual_text = true,
			})
		end,
	},
	{ "tpope/vim-abolish", cmd = { "Abolish", "Subvert", "S" }, keys = { "cr" } },
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
	{ "tpope/vim-rsi", event = "InsertEnter" },
	{ "tpope/vim-sleuth", event = { "BufNewFile", "BufReadPre", "BufFilePre" } },
	{ "tpope/vim-obsession", cmd = { "Obsession" } },
	{ "tpope/vim-speeddating", keys = { { "<c-a>", mode = { "n", "v" } }, { "<c-x>", mode = { "n", "v" } } } },
	-- ────────────────────────────────── U ──────────────────────────────────
	-- ────────────────────────────────── V ──────────────────────────────────
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
			-- vim.cmd("autocmd FileType vimwiki set filetype=markdown")
			vim.treesitter.language.register("markdown", "vimwiki")
			vim.g.vimwiki_listsyms = "    x"
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_list = { { path = "~/notes/wiki/", syntax = "markdown", ext = ".md", auto_diary_index = 1 } }
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".mkd"] = "markdown", [".wiki"] = "media" }
		end,
	},
	-- ────────────────────────────────── W ──────────────────────────────────
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate", "MasonUninstallAll" },
		dependencies = {
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					check_outdated_packages_on_open = true,
					backdrop = 100,
				},
				max_concurrent_installers = 1,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				require("lsp_signature").on_attach({
					hint_enable = false,
					bind = true,
					handler_opts = { border = "rounded" },
				}, bufnr)

				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end
			require("config.native-lsp").setup(on_attach, capabilities)
		end,
	},
	{
		"willothy/flatten.nvim",
		lazy = false,
		opts = {
			window = {
				open = "alternate",
			},
		},
		priority = 1001,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
		ft = {
			"astro",
			"glimmer",
			"handlebars",
			"html",
			"javascript",
			"javascriptreact",
			"jsx",
			"liquid",
			"markdown",
			"php",
			"rescript",
			"svelte",
			"tsx",
			"twig",
			"typescript",
			"typescriptreact",
			"vue",
			"xml",
		},
	},
	-- ────────────────────────────────── X ──────────────────────────────────
	-- ────────────────────────────────── Y ──────────────────────────────────
	-- ────────────────────────────────── Z ──────────────────────────────────
	-- {
	-- 	"zongben/capsoff.nvim",
	-- 	build = ":CapsLockOffBuild",
	-- 	opts = {},
	-- 	event = { "InsertLeave" },
	-- },
}, {
	ui = {
		border = "rounded",
		backdrop = 100,
	},
})

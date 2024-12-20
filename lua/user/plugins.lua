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
	--A
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
	{ "arthurxavierx/vim-unicoder", event = "InsertEnter" },
	{
		"akinsho/bufferline.nvim",
		event = "UIEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				themable = true,
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
	--B
	--C
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
				-- #1A1A2F #1D182E #171421, terminal background: #171421
				mocha = { base = "#191724" },
			},
			highlight_overrides = {
				all = function(colors)
					return {
						WinSeparator = { fg = "#554D80" },
					}
				end,
			},
			integrations = {
				blink_cmp = true,
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
	--D
	--E
	{
		"echasnovski/mini.bracketed",
		keys = {
			{ "]", mode = { "n", "v" } },
			{ "[", mode = { "n", "v" } },
		},
		version = false,
		opts = {
			conflict = { suffix = "", options = {} },
			diagnostic = { suffix = "", options = {} },
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
				groups = {
					all = {
						NormalFloat = { fg = "fg1", bg = "NONE" },
					},
				},
			})
		end,
	},
	--F
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- presets = {
			-- 	-- lsp_doc_border = true,
			-- },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
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
	{
		"folke/zen-mode.nvim",
		opts = {
			window = { width = 100 },
			on_open = function(win)
				vim.cmd("normal zt<CR>")
			end,
			on_close = function(win)
				vim.cmd("normal zt<CR>")
			end,
		},
		cmd = { "ZenMode" },
	},
	--G
	{
		"ghassan0/telescope-glyph.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = { "Telescope glyph" },
	},
	-- { "github/copilot.vim" },
	--H
	--I
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
	--J
	{ "jghauser/follow-md-links.nvim", ft = { "markdown" } },
	{ "junkblocker/git-time-lapse", cmd = { "GitTimeLapse" } },
	{
		"jvgrootveld/telescope-zoxide",
		cmd = { "Telescope zoxide list" },
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("zoxide")
		end,
	},
	--K
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
	{
		"kwakzalver/duckytype.nvim",
		cmd = "DuckyType",
		opts = {
			expected = "english_common",
			number_of_words = 50,
			window_config = { border = "rounded" },
			highlight = {
				good = "Comment",
				remaining = "Normal",
			},
		},
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
	--L
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
		event = { "BufReadPost", "BufNewFile" },
	},
	-- { "lukas-reineke/virt-column.nvim", opts = {}, event = {
	-- 	"BufReadPost",
	-- 	"BufNewFile",
	-- } },
	{ "LunarVim/bigfile.nvim", event = "BufReadPre", opts = {} },
	--M
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
	--N
	{
		"neovim/nvim-lspconfig",
		after = "mason-lspconfig.nvim",
		lazy = true,
		config = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"
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
						icon = "📆 ",
						desc = "Calendar",
						action = "Calendar",
						key = "c",
					},
					{
						icon = "📚 ",
						desc = "Open Wiki",
						action = "VimwikiIndex",
						key = "w",
					},
					{
						-- icon = "🗂️ ",
						icon = "💾 ",
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
						icon = "⚡ ",
						desc = "Manage LSP/Formatters/...                    ",
						action = "Mason",
						key = "m",
					},
					{
						icon = "🔧 ",
						desc = "Extensions",
						action = "Lazy",
						key = "x",
					},
					{
						icon = "🛠️ ",
						desc = "Neovim Config Files",
						key = "v",
						action = function()
							require("telescope.builtin").find_files({
								prompt_title = "Neovim Config Files",
								cwd = "~/.config/nvim",
								hidden = true,
							})
						end,
					},
					{
						icon = "⏻ ",
						desc = "Quit",
						action = "q",
						key = "q",
					},
				},
				-- footer = {
				-- 	"👑 " .. "Dear Me in 6 months, I'm going to make you so damn proud." .. " 👑",
				-- },
				packages = { enable = true },
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
					enable = false, -- don't toggle
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
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "Telescope" },
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						vertical = {
							prompt_position = "top",
							mirror = true,
						},
						flex = {
							flip_columns = 120,
						},
						width = 0.90,
						height = 0.85,
						preview_cutoff = 0,
					},
					prompt_prefix = "   ",
					selection_caret = " ",
					entry_prefix = "  ",
					sorting_strategy = "ascending",
					layout_strategy = "flex",
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = { "node_modules" },
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = { truncate = 3 },
					-- path_display = { "filename_first" },
					winblend = 0,
					set_env = { ["COLORTERM"] = "truecolor" },
					mappings = {
						n = {
							["q"] = require("telescope.actions").close,
							["<C-c>"] = require("telescope.actions").close,
							["<M-h>"] = "which_key",
							["<C-r>"] = require("telescope.actions").delete_buffer
								+ require("telescope.actions").move_to_top,
						}, -- n
						i = {
							["<M-h>"] = "which_key",
							["<C-r>"] = require("telescope.actions").delete_buffer
								+ require("telescope.actions").move_to_top,
						}, -- i
					}, -- mappings
				},
				extensions = {
					emoji = {
						action = function(emoji)
							vim.fn.setreg("*", emoji.value)
							vim.api.nvim_put({ emoji.value }, "c", false, true)
						end,
					},
					glyph = {
						action = function(glyph)
							vim.fn.setreg("*", glyph.value)
							vim.api.nvim_put({ glyph.value }, "c", false, true)
						end,
					},
					zoxide = { prompt_title = "Projects" },
				},
				extensions_list = { "emoji", "fzf", "glyph", "zoxide" },
			})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
		dependencies = { "nvim-telescope/telescope.nvim" },
		ft = "TelescopePrompt",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },
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
					require("null-ls").builtins.formatting.asmfmt,
					-- require("null-ls").builtins.formatting.clang_format.with({
					-- 	filetypes = { "asm" },
					-- 	args = { "-style=llvm" },
					-- }),
					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.black,
					require("null-ls").builtins.formatting.djhtml,
					-- require("null-ls").builtins.formatting.djlint,
					require("null-ls").builtins.formatting.gofmt,
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
					if client.supports_method("textDocument/formatting") then
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
	--O
	--P
	--Q
	--R
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
	--S
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		opts = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			completion = {
				menu = {
					border = "rounded",
					winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
					window = { border = "rounded" },
				},
			},
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
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
			view_options = {
				show_hidden = true,
			},
		},
	},
	--T
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
	{ "tpope/vim-rhubarb", event = "UIEnter" },
	{ "tpope/vim-rsi", event = "InsertEnter" },
	{ "tpope/vim-sleuth", event = { "BufNewFile", "BufReadPost", "BufFilePost" } },
	{ "tpope/vim-obsession", cmd = { "Obsession" } },
	{ "tpope/vim-speeddating", keys = { { "<c-a>", mode = { "n", "v" } }, { "<c-x>", mode = { "n", "v" } } } },
	--U
	--V
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
			vim.treesitter.language.register("markdown", "vimwiki")
			vim.g.vimwiki_listsyms = "    x"
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_list = { { path = "~/notes/wiki/", syntax = "markdown", ext = ".md", auto_diary_index = 1 } }
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".mkd"] = "markdown", [".wiki"] = "media" }
		end,
	},
	--W
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
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local on_attach = function(client, bufnr)
				require("lsp_signature").on_attach({
					hint_enable = false,
					bind = true,
					handler_opts = { border = "rounded" },
				}, bufnr)

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end
			local lspconfig = require("lspconfig")
			local servers = {
				ts_ls = {
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						on_attach(client, bufnr)
					end,
					capabilities = capabilities,
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" },
					root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
				},
				html = {
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "html", "htmldjango", "gohtml", "tmpl.html", "template" },
				},
				emmet_ls = {
					on_attach = on_attach,
					capabilities = capabilities,
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
					},
					-- init_options = {
					-- 	html = {
					-- 		options = {
					-- 			["bem.enabled"] = true,
					-- 		},
					-- 	},
					-- },
				},
				jsonls = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
				cssls = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
				rust_analyzer = {
					on_attach = on_attach,
					capabilities = capabilities,
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
				},
				gopls = {
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = { "gopls", "serve" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							templateExtensions = { "tpl", "yaml", "tmpl", "tmpl.html" },
							experimentalPostfixCompletions = true,
							gofumpt = true,
							usePlaceholders = true,
							analyses = {
								-- shadow = true,
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
				},
				pyright = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				clangd = {
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
				},
				neocmake = {
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = { "neocmakelsp", "--stdio" },
					filetypes = { "cmake" },
					root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
				},
				texlab = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
			}
			for server, config in pairs(servers) do
				lspconfig[server].setup(config)
			end
			require("mason-lspconfig").setup()
		end,
	},
	{ "windwp/nvim-ts-autotag", event = { "InsertEnter" } },
	--X
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

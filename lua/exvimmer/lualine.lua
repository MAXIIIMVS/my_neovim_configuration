require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto", -- or auto, moonfly, tokyonight, codedark, gruvbox, ...
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		-- disabled_filetypes = { 'packer', 'NvimTree', 'fugitive', 'toggleterm'},
		-- disabled_filetypes = { 'packer', 'NvimTree'},
		globalstatus = true, -- NOTE: Neovim 0.7 or higher, or use laststatus = 3
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {}, -- enable nvim-tree, fugitive, ...
})

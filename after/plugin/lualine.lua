local lualine = require("lualine")
local custom_auto = require("lualine.themes.auto")
custom_auto.normal.c.bg = "NONE"
custom_auto.insert.c.bg = "NONE"
custom_auto.terminal.c.bg = "NONE"
custom_auto.visual.c.bg = "NONE"
custom_auto.command.c.bg = "NONE"
custom_auto.replace.c.bg = "NONE"

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

lualine.setup(config)

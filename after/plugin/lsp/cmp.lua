require("cmp").event:on(
	"confirm_done",
	require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
)

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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

local options = {
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
		{ name = "emoji", option = { insert = false } },
		{ name = "nvim_lsp" },
		{
			name = "luasnip",
			entry_filter = function()
				return not require("cmp.config.context").in_treesitter_capture("string")
					and not require("cmp.config.context").in_syntax_group("String")
			end,
		},
		{ name = "buffer" },
		{ name = "path" },
		{ name = "vim-dadbod-completion" },
		-- { name = "nvim_lsp_signature_help" },
		-- { name = "nvim_lua" },
	},
}

-- Set configuration for specific filetype.
-- require("cmp").setup.filetype("gitcommit", {
-- 	sources = cmp.config.sources({
-- 		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
-- 	}, {
-- 		{ name = "buffer" },
-- 	}),
-- })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
---@diagnostic disable-next-line: missing-fields
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

require("cmp").setup(options)

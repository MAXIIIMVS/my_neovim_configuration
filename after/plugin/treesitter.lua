require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"c",
		"cpp",
		"go",
		"javascript",
		"typescript",
		"python",
		"bash",
		"astro",
		"svelte",
		"vue",
		"c_sharp",
		"cmake",
		"css",
		"scss",
		"diff",
		"gomod",
		"gosum",
		"gowork",
		"graphql",
		"prisma",
		"json",
		"html",
		"htmldjango",
		"jsdoc",
		"ini",
		"json5",
		"make",
		"markdown",
		"ninja",
		"php",
		"pug",
		"regex",
		"rust",
		"ruby",
		"sql",
		"toml",
		"tsx",
		"vim",
		"yaml",
	},
	sync_install = false,
	ignore_install = {},
	indent = {
		enable = false,
		disable = {},
	},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
})

require("lspconfig.ui.windows").default_options.border = "rounded"

require("lspconfig").util.default_config.capabilities = vim.tbl_deep_extend(
	"force",
	require("lspconfig").util.default_config.capabilities,
	require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
)

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

local mason_default_settings = {
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
}

require("mason").setup(mason_default_settings)

require("mason-lspconfig").setup()
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

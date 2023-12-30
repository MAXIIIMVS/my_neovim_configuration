local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspinstaller = require("mason")
local mason_lspconfig = require("mason-lspconfig")

require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
	"force",
	lsp_defaults.capabilities,
	cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.name == "clangd" or client.name == "prismals" then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
		vim.api.nvim_command([[augroup END]])
	end

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	vim.keymap.set("n", "gd", "<cmd>silent lua vim.lsp.buf.definition()<CR>", bufopts)
	-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	-- vim.keymap.set("i", "<C-x>", "<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
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

lspinstaller.setup(mason_default_settings)

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
		})
	end,
	-- Next, you can provide targeted overrides for specific servers.
	["cssls"] = function()
		lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.cssls.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
		})
	end,
	["emmet_ls"] = function()
		lspconfig.emmet_ls.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
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
			},
		})
	end,
	["html"] = function()
		lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.html.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
			filetypes = {
				"html",
				"handlebars",
				"htmldjango",
				"blade",
				"gohtml",
				"tmpl.html",
			},
		})
	end,
	["jsonls"] = function()
		lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.jsonls.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
		})
	end,
	["tsserver"] = function()
		lspconfig.tsserver.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
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
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
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
		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
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
		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
			cmd = { "gopls", "serve" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		})
	end,
})

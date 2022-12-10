local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspinstaller = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
	"force",
	lsp_defaults.capabilities,
	cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- if client.name == "clangd" or client.name == "gopls" then
	if client.name == "clangd" then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
		vim.api.nvim_command([[augroup END]])
	end

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- TODO: Replace gs with the lspsaga version when it's supported again
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("i", "<C-x>", "<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local mason_default_settings = {
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
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
			opts = {
				filetypes = {
					"html",
					"css",
					"sass",
					"scss",
					"less",
					"vue",
					"javascriptreact",
					"typescriptreact",
					"javascript.jsx",
					"typescript.tsx",
					-- "htmldjango" -- doesn't work
					-- "gohtml" -- TODO: check
					-- "tmpl.html" -- TODO: check
				},
			},
		})
	end,
	["html"] = function()
		lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
		lspconfig.html.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
			opts = {
				filetypes = { "html", "handlebars", "htmldjango", "blade" },
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
		lspconfig["tsserver"].setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
			opts = {
				filetypes = {
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"javascript.jsx",
					"typescript.tsx",
				},
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
	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			on_attach = on_attach,
			capabilities = lsp_defaults.capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,
})

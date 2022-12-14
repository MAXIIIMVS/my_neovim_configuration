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
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	-- TODO: Replace gs with the lspsaga version when it's supported again
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("i", "<C-x>", "<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("n", "<space>mI", ":Mason<CR>", bufopts)
	vim.keymap.set("n", "<space>mi", ":LspInfo<CR>", bufopts)
	vim.keymap.set("n", "<space>ms", ":LspStart<CR>", bufopts)
	vim.keymap.set("n", "<space>mS", ":LspStop<CR>", { noremap = true })
	vim.keymap.set("n", "<space>ma", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
	vim.keymap.set("n", "<space>mr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
	vim.keymap.set("n", "<space>ml", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

local mason_default_settings = {
	ensure_installed = {
		"black",
		"clangd",
		"cmake-language-server",
		"cmakelang",
		"csharp-language-server",
		"csharpier",
		"css-lsp",
		"dockerfile-language-server",
		"emmet-ls",
		-- "eslint-lsp",
		"eslint_d",
		"gopls",
		"graphql-language-service-cli",
		"html-lsp",
		"json-lsp",
		"lua-language-server",
		-- "prettier",
		"prettierd",
		"prisma-language-server",
		"pyright",
		"rust-analyzer",
		"stylua",
		"typescript-language-server",
		"vue-language-server",
		"yaml-language-server",
	},
	automatic_installation = false,
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
					"gohtml",
					"tmpl.html",
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
				filetypes = {
					"html",
					"handlebars",
					"htmldjango",
					"blade",
					"gohtml",
					"tmpl.html",
				},
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

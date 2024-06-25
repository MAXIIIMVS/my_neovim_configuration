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

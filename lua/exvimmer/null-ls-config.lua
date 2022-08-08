local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.prettierd, formatting.black, formatting.djhtml,
    formatting.rustfmt, code_actions.eslint_d
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd[[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end

    if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        augroup document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
    end
  end
})


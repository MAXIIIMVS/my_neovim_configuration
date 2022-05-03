local lsp_installer = require('nvim-lsp-installer')

local function on_attach(client, bufnr)
  -- formatting
  if client.name == 'tsserver' or client.name == 'html' or client.name == "cssls" or client.name == "jsonls" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  if client.name == "clangd" or client.name == 'gopls' then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end
end

lsp_installer.on_server_ready(function(server)
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local opts = {capabilities = capabilities, on_attach = on_attach}

  if server.name == "tsserver" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {"javascript", "javascriptreact", "javascript.jsx",
        "typescript", "typescriptreact", "typescript.tsx"}
    }, opts)
  end

  if server.name == "html" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {"html","handlebars","htmldjango","blade"}
    }, opts)
  end

  if server.name == "emmet_ls" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {
        "html",
        "css",
        "vue",
        -- "javascript",
        -- "typescript",
        "typescriptreact",
        "javascriptreact",
        -- "htmldjango" -- doesn't work
      },
    }, opts)
  end

  if server.name == "sumneko_lua" then
    opts = vim.tbl_deep_extend("force", {
      settings = {
        Lua = {
          runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
          diagnostics = {globals = {'vim'}},
          workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false},
          telemetry = {enable = false}
        }
      }

    }, opts)
  end
  server:setup(opts)
end)

local lspconfig = require("lspconfig")
local lspinstaller= require("nvim-lsp-installer")

lspinstaller.setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "rust_analyzer",
    "bashls",
    "tsserver",
    "pyright",
    "cssls",
    "emmet_ls",
    "graphql",
    "html",
    "jsonls",
    "prismals",
    "dockerls",
    "sumneko_lua",
    "vuels",
  },
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

local function on_attach(client, bufnr)
  if (
      client.name == "tsserver"
      or client.name == "html"
      or client.name == "cssls"
      or client.name == "jsonls"
    ) then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
  end

  if client.name == "clangd" or client.name == "gopls" then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end
end


for _, server in ipairs(lspinstaller.get_installed_servers()) do
  local opts = {}
  if server.name == "tsserver" then
    opts = vim.tbl_deep_extend(
    "force", {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
      }
    },
    opts)
  elseif server.name == "html" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {"html","handlebars","htmldjango","blade"}
    }, opts)
  elseif server.name == "emmet_ls" then
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
  elseif server.name == "sumneko_lua" then
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

  lspconfig[server.name].setup{
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()),
    opts = opts,
  }
end

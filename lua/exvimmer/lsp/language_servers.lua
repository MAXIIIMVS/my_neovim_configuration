local lspconfig = require("lspconfig")
local lspinstaller= require("mason")
local mason_lspconfig= require("mason-lspconfig")

local DEFAULT_SETTINGS = {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  },
  -- Limit for the maximum amount of packages to be installed at the same time.
  -- Once this limit is reached, any further packages that are requested to be
  -- installed will be put in a queue.
  max_concurrent_installers = 1,
}

lspinstaller.setup(DEFAULT_SETTINGS)

local function on_attach(client, bufnr)
  if (
      client.name == "tsserver"
      or client.name == "html"
      or client.name == "cssls"
      or client.name == "volar"
      or client.name == "jsonls"
      or client.name == "rust_analyzer"
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

mason_lspconfig.setup()
mason_lspconfig.setup_handlers {
  function (server_name)

  local opts = {}
  if server_name == "tsserver" then
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
  elseif server_name == "html" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {"html","handlebars","htmldjango","blade"}
    }, opts)
  elseif server_name == "emmet_ls" then
    opts = vim.tbl_deep_extend("force", {
      filetypes = {
        "html",
        "css",
        "sass",
        "scss",
        "less",
        "vue",
        -- "javascript",
        -- "typescript",
        "typescriptreact",
        "javascriptreact",
        -- "htmldjango" -- doesn't work
      },
    }, opts)
  elseif server_name == "sumneko_lua" then
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
  elseif server_name == "rust_analyzer" then
    opts = vim.tbl_deep_extend("force", {
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "self",
          },
          cargo = {
            loadOutDirsFromCheck = true
          },
          procMacro = {
            enable = true
          },
          checkOnSave = {
            command = "clippy"
          },
        }
      }
    }, opts)
  end
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()),
      opts = opts,
    }
  end,
}

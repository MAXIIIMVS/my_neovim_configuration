local lspconfig = require("lspconfig")
local lspformat = require("lsp-format")
local lspinstaller = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local util = require 'vim.lsp.util'

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

local formatting_callback = function(client, bufnr)
  vim.keymap.set('n', '<space>f', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end, { buffer = bufnr })
end

mason_lspconfig.setup()
mason_lspconfig.setup_handlers {
  function(server_name)

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
        filetypes = { "html", "handlebars", "htmldjango", "blade" }
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
            runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false }
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
      on_attach = function(client, bufnr)
        -- if client.name == "clangd" or client.name == "gopls" then
        --   vim.api.nvim_command [[augroup Format]]
        --   vim.api.nvim_command [[autocmd! * <buffer>]]
        --   vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
        --   vim.api.nvim_command [[augroup END]]
        -- end

        lspformat.on_attach(client, bufnr)
        formatting_callback(client, bufnr)
      end,
      -- on_attach =  lspformat.on_attach,
      capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()),
      opts = opts,
    }
  end,
}

local u = require('utils')
local opts = { noremap = true, silent = true }

require("bufferline").setup {
  options = {
    sort_by = 'relative_directory',
    -- numbers = "ordinal",
    separator_style = 'slant',
    diagnostics = "nvim_lsp",
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
        end
        return result
      end,
    }
  }
}

u.map('n', '<S-Tab>', '::BufferLineCyclePrev<CR>', opts)
u.map('n', '<Tab>', '::BufferLineCycleNext<CR>', opts)
u.map('n', ']b', ':BufferLineMoveNext<CR>', opts)
u.map('n', '[b', ':BufferLineMovePrev<CR>', opts)
u.map('n', ']c', ':BufferLineCloseRight<CR>', opts)
u.map('n', '[c', ':BufferLineCloseLeft<CR>', opts)
u.map('n', '<space>p', ':BufferLinePick<CR>', opts)
u.map('n', '<space>P', ':BufferLinePickClose<CR>', opts)
-- u.map('n', '<leader>g', ':BufferLineGoToBuffer ')
u.map('n', ';p', ':BufferLineTogglePin<CR>', opts)

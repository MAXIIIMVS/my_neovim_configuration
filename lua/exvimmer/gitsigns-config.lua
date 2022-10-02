local u = require('utils')
local opts = { noremap = true, silent = true }

require('gitsigns').setup {
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> <author_mail>: <summary>',
}

vim.cmd('highlight GitSignsCurrentLineBlame guifg=#666666')

u.map('n', ']h', ':Gitsigns next_hunk<CR>', opts)
u.map('n', '[h', ':Gitsigns prev_hunk<CR>', opts)
u.map('n', '<space>sp', ':Gitsigns preview_hunk<CR>', opts)
u.map('n', '<space>sr', ':Gitsigns reset_hunk<CR>', opts)
u.map('n', '<space>sb', ':Gitsigns blame_line<CR>', opts)
u.map('n', '<space>st', ':Gitsigns toggle_current_line_blame<CR>', opts)
u.map('n', '<space>sd', ':Gitsigns toggle_deleted<CR>', opts)

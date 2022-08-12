local u = require('utils')
local opts = { noremap = true, silent = true }

require('nvim_comment').setup({
  comment_empty = false,
})


require("todo-comments").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

u.map('n', '<c-_>', ':CommentToggle<CR>', opts)
u.map('v', '<c-_>', ':CommentToggle<CR>', opts)
u.map('i', '<c-_>', '<ESC>:CommentToggle<CR>', opts)

local u = require('utils')
local opts = { noremap = true, silent = true }

require('nvim_comment').setup({
  comment_empty = true,
})


require("todo-comments").setup {
  keywords = {
    FIX = { icon = "🩺", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = { icon = "⚓", color = "#00A3FF" },
    HACK = { icon = "💀", color = "#F945C1" },
    WARN = { icon = "💡", color = "#FBBF24", alt = { "WARNING", "XXX" } },
    PERF = { icon = "🎭", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = "📝", color = "#10B981", alt = { "INFO" } },
    TEST = { icon = "🛡️", color = "#FFFD00", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  highlight = {
    multiline = true, -- enable multine todo comments
    comments_only = false,
    -- exclude = {}, -- list of file types to exclude highlighting
  },
}

u.map('n', '<c-_>', ':CommentToggle<CR>', opts)
u.map('v', '<c-_>', ':CommentToggle<CR>', opts)
u.map('i', '<c-_>', '<ESC>:CommentToggle<CR>', opts)
u.map('n', ';cT', 'OTODO: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';ct', 'ITODO: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cE', 'OTEST: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';ce', 'ITEST: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cN', 'ONOTE: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';cn', 'INOTE: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cF', 'OFIX: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';cf', 'IFIX: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cW', 'OWARNING: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';cw', 'IWARNING: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cH', 'OHACK: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';ch', 'IHACK: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cP', 'OPERF: <ESC>:CommentToggle<CR>f:a ', opts)
u.map('n', ';cp', 'IPERF: <ESC>:CommentToggle<CR>^', opts)
u.map('n', ';cl', ':TodoLocList<CR>', opts)

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

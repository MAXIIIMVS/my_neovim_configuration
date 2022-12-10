local u = require('utils')
local opts = { noremap = true, silent = true }
local saga = require('lspsaga')

saga.init_lsp_saga({
  border_style = "rounded",
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  code_action_icon = "💡",
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = false,
    update_time = 0,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  finder_action_keys = {
    open = { 'o', '<CR>' },
    vsplit = 'v',
    split = 's',
    tabe = 't',
    quit = { 'q', '<ESC>' },
  },
  code_action_keys = {
    quit = 'q',
    exec = '<CR>',
  },
  symbol_in_winbar = {
    in_custom = true
  }
})

u.map("n", "<leader>S", "<cmd>LSoutlineToggle<CR>", opts)
u.map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
u.map('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
u.map('n', '<space>ca', ':Lspsaga code_action<CR>', opts)
-- u.map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>', opts)
u.map('n', '<space>rn', '<cmd>Lspsaga rename<CR>', opts)
u.map('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
u.map('n', '<space>d', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
-- keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
u.map('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
u.map('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

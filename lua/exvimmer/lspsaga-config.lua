local u = require('utils')
local opts = { noremap = true, silent = true }

local lspsaga = require 'lspsaga'
lspsaga.setup {
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "", -- original one
  -- error_sign = ' ',
  warn_sign = "",
  -- hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  -- code_action_icon = " ",
  code_action_prompt = { enable = false, sign = false, sign_priority = 40, virtual_text = true },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>"
  },
  code_action_keys = { quit = "q", exec = "<CR>" },
  rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
  definition_preview_icon = "  ",
  -- border_style = "single",
  border_style = "round",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. "
}

-- u.map('n', '<c-j>', ':Lspsaga diagnostic_jump_next<CR>', opts)
u.map('n', 'K', ':Lspsaga hover_doc<CR>', opts)
u.map('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
u.map('n', '<space>ca', ':Lspsaga code_action<CR>', opts)
u.map('v', '<space>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>', opts)
u.map('n', '<c-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
u.map('n', '<c-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)
u.map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>', opts)
u.map('n', '<space>rn', '<cmd>lua require(\'lspsaga.rename\').rename()<CR> ', opts)
u.map('n', 'gp', ':Lspsaga preview_definition<CR>', opts)
u.map('n', '<space>d', ':Lspsaga show_line_diagnostics<CR>', opts)
u.map('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>', opts)
u.map('n', ']e', ':Lspsaga diagnostic_jump_next<CR>', opts)
-- u.map('n', '<leader>t', ':Lspsaga open_floaterm<CR>', opts)
-- u.map('t', '<leader>t', '<C-d><C-\\><C-n>:Lspsaga close_floaterm<CR>', opts)

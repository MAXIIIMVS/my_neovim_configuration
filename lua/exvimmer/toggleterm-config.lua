local u = require('utils')
local cmd = vim.cmd
local opts = { noremap=true, silent=true }

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  -- NOTE: I cannot live without <C-l>
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require"toggleterm".setup {
  size = 13,
  open_mapping = [[<c-\>]],
  close_on_exit = true, -- close the terminal window when the process exits
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1',
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  float_opts = {
    border = 'single',
    width = 140,
    height = 200,
    winblend = 0,
  },
}

-- lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    width = 200,
    height = 200,
    winblend = 0,
    border = "double",
  },
  close_on_exit = true,
  hidden = true,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

u.map('n', '<space>tv', ':ToggleTerm size=80 direction=vertical<CR>', opts)
u.map('n', '<space>th', ':ToggleTerm direction=horizontal<CR>', opts)
u.map('n', '<space>tf', ':ToggleTerm size=160 direction=float<CR>', opts)

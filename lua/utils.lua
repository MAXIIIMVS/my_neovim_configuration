local M = {} -- The module to export
local cmd = vim.cmd

-- We will create a few autogroup, this function will help to avoid
-- always writing cmd('augroup' .. group) etc..
function M.create_augroup(autocmds, name)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

-- Add a apth to the runtimepath
function M.add_rtp(path)
  local rtp = vim.o.rtp
  rtp = rtp .. ',' .. path
end

function M.get_setup(name)
  return string.format('require("exvimmer/%s-config")', name)
end

-- Map a key with optional options
function M.map(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, action, options)
end

-- Map a key to a lua callback
function M.map_lua(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, "<cmd>lua " .. action .. "<cr>", options)
end

-- Buffer local mappings
function M.map_buf(mode, keys, action, options, buf_nr)
  if options == nil then
    options = {}
  end
  local buf = buf_nr or 0
  vim.api.nvim_buf_set_keymap(buf, mode, keys, action, options)
end

function M.map_lua_buf(mode, keys, action, options, buf_nr)
  if options == nil then
    options = {}
  end
  local buf = buf_nr or 0
  vim.api.nvim_buf_set_keymap(buf, mode, keys, "<cmd>lua " .. action .. "<cr>", options)
end

function M.get_top_level()
  local tl = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local sub = string.sub(tl, 1, 1)

  -- NOTE: you might need to change this on windows
  if sub ~= "/" and sub ~= "." then
    return "."
  else
    return tl
  end
end

M.my_fd = function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require'telescope.builtin'.find_files(opts)
end

M.my_rg = function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require'telescope.builtin'.live_grep(opts)
end
-- We want to be able to access utils in all our configuration files
-- so we add the module to the _G global variable.
_G.utils = M
return M -- Export the module

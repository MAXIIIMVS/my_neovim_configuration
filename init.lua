-- TODO: remove unused variables
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local w = vim.wo
local b = vim.bo
local utils = require('utils')

require('plugins')
require('settings')
require('mappings')

-- NOTE: put this at the end
o.secure = true -- BUG: security risk; don't switch this off

-- Just use vim.
for name, key in pairs {
  'Left',
  'Right',
  'Up',
  'Down',
  'PageUp',
  'PageDown',
  'End',
  'Home',
  Delete = 'Del',
} do
  if type(name) == 'number' then
    name = key
  end

  local keymap = function(modes, left, right, options)
    options = vim.tbl_extend('force', { noremap = true, silent = true }, options or {})
    vim.keymap.set(modes, left, right, options)
  end

  keymap('n', '<' .. key .. '>', '<cmd>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
  keymap('v', '<' .. key .. '>', '<cmd><C-u>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
  keymap('i', '<' .. key .. '>', '<C-o><cmd>echo "No ' .. name .. ' for you!"<CR>', { noremap = false })
end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<leader>,', ',', { noremap = true, silent = true })

vim.o.number = true
vim.o.relativenumber = true

vim.o.autoread = true
vim.o.fileencoding = 'UTF-8'
vim.o.mouse = 'a'
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.undofile = false
vim.o.clipboard = 'unnamedplus'
vim.o.backup = false
vim.o.writebackup = false
vim.o.cursorline = true
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.wrap = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.ignorecase = true
-- vim.o.smartcase = true
vim.o.list = true
vim.o.listchars = 'tab: ·,trail:×,nbsp:%,eol:·,extends:»,precedes:«'
vim.o.termguicolors = true

vim.keymap.set('n', '<C-n>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>')
vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>')

local function git_clone(url, dir, callback)
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/' .. dir

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      url,
      install_path,
    }
    callback(vim.v.shell_error)
  end
end

git_clone('https://github.com/lewis6991/impatient.nvim', 'impatient.nvim', function(res)
  if res == 0 then
    vim.cmd [[packadd impatient.nvim]]
  end
end)

xpcall(function()
  require 'impatient'
end, function(_)
  vim.api.nvim_echo({ { 'Error while loading impatient', 'ErrorMsg' } }, true, {})
end)

git_clone('https://github.com/wbthomason/packer.nvim', 'packer.nvim', function(res)
  if res == 0 then
    vim.g.packer_bootstrap = true
    vim.cmd [[packadd packer.nvim]]
  end
end)

require 'config.plugins'

if vim.g.packer_bootstrap then
  require('packer').sync()
end
